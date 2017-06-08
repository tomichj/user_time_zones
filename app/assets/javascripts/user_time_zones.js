// Mutator, watches for an element with [data-behavior~=guess-time-zone-offset].
// Sets best guess at timezone to that element.
var MutationObserver, observe, observer, guessTimeZoneOffset, selector;

MutationObserver = window.MutationObserver || window.WebKitMutationObserver;
observer = void 0;
selector = "[data-behavior~=guess-time-zone-offset]";

guessTimeZoneOffset = function(field) {
  if (field) {
    field.value = -(new Date().getTimezoneOffset() / 60);
  }
};

observe = function() {
  if (!observer) {
    observer = new MutationObserver(check);
    observer.observe(window.document.documentElement, {childList: true, subtree: true});
  }
  check();
};

check = function() {
  var element, elements;
  elements = window.document.querySelectorAll(selector);
  for (var i = 0; i < elements.length; i++) {
    element = elements[i];
    if (!element.ready) {
      element.ready = true;
      guessTimeZoneOffset.call(element, element);
    }
  }
};

(function() { return observe(); })();
