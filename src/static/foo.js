"use strict";

String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.split(search).join(replacement);
};

function _(selector, src) {
  if (src === undefined) {
    src = document;
  }
  return src.querySelector(selector);
}
function __(selector) {
  return document.querySelectorAll(selector);
}

// waiting for document to be ready

function ready(callback) {
  // in case the document is already rendered
  if (document.readyState !== 'loading') callback();
  // modern browsers
  else if (document.addEventListener) document.addEventListener('DOMContentLoaded', callback);
  // IE <= 8
  else document.attachEvent('onreadystatechange', function () {
      if (document.readyState === 'complete') callback();
    });
}

// CLASS

function addClass(el, className) {
  if (!el) return;
  if (el.classList)
    el.classList.add(className);
  else
    el.className += ' ' + className;
}
function removeClass(el, className) {
  if (!el) return;
  if (el.classList)
    el.classList.remove(className);
  else
    el.className = el.className.replace(new RegExp('(^|\\b)' + className.split(' ').join('|') + '(\\b|$)', 'gi'), ' ');
}
function toggleClass(el, addedClass) {
  if (!el) return;
  if (el.classList.contains(addedClass)) {
    el.classList.remove(addedClass);
  }
  else {
    el.classList.add(addedClass);
  }
};
