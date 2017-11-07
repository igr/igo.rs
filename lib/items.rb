require 'erb'
require 'date'
require 'pathname'

$alls = Hash.new

### --- preprocessing phase ---

# registers items into kind's collections
def my_item_register(item)
  if !item.key?(:date)
  	return
  end

  my_item_titles(item)

  kind = item[:kind]

  if kind == nil
    path = item.identifier
    path = Pathname(path).dirname.to_s
    kind = path[1..-1]
    item[:kind] = kind
  end

  docs = $alls[kind]

  if docs == nil
  	docs = Array.new
  	$alls[kind] = docs
  end

  docs.push(item.identifier)
end

# resolve the item title.
# if not defined in the header, parse the md and take the first # and ##
def my_item_titles(item)
  if !item.key?(:title)
    item[:title] = ''
    item[:subtitle] = ''

    md = [File.open(item[:filename]).read]
    md.each{|content|
      content.lines.each{|line|
        if line[0..1] == '##'
          item[:subtitle] = line[2..-1].strip
          break
        elsif line[0] == '#'
          item[:title] = line[1..-1].strip
          break
        end
      }
    }

  end
end


# Sort items and add links to next/prev
def sort_all_items()
  $alls_alt = Hash.new

  $alls.each { |k, v|
		result = v.sort {|left, right| (@items[left])[:date] <=> (@items[right])[:date]}
    $alls_alt[k] = result
	}

  $alls = $alls_alt

  # prev/next

  $alls.each { |k,arr|
    arr.each_with_index { |it, ndx|
      if (ndx > 0)
        @items[it][:prev] = arr[ndx - 1]
      end
      if (ndx < arr.size - 1)
        @items[it][:next] = arr[ndx + 1]
      end
    }
  }
end


### --- rendering phase ---

# returns sorted array of items for given kind
# may return nil if kind is not available
def my_items_of_kind(kind)
	return $alls[kind]
end


def date(item)
  date = Date.strptime(item[:date].to_s, "%Y-%m-%d")
  return date.day.to_s + '. ' + date_month(date.month) + ' ' + date.year.to_s + '.'
end

# converts month to serbian month name
def date_month(month)
  case month
    when 1
      return 'januar'
    when 2
      return 'februar'
    when 3
      return 'mart'
    when 4
      return 'april'
    when 5
      return 'maj'
    when 6
      return 'jun'
    when 7
      return 'jul'
    when 8
      return 'avgust'
    when 9
      return 'septembar'
    when 10
      return 'oktobar'
    when 11
      return 'novembar'
    when 12
      return 'decembar'
  end
end