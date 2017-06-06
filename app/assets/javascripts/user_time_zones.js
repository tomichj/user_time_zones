// Mutator, watches for an element with [data-behavior~=guess-time-zone-offset].
// Adds best guess timezone to that element.
//
// Element can be created using

var MutationObserver = window.MutationObserver || window.WebKitMutationObserver || window.MozMutationObserver;

function guessTimeZoneOffset(time_zone_offset_field) {
  if (time_zone_offset_field) {
    time_zone_offset_field.value = -(new Date().getTimezoneOffset() / 60);
  }
}

var observer = new MutationObserver(function() {
  console.log("creating new time zone offset mutation observer")
  var field = window.document.querySelector("[data-behavior~=guess-time-zone-offset]");
  guessTimeZoneOffset(field);
});

observer.observe(window.document.documentElement, {
  childList: true,
  subtree: true,
  attributes: false,
  characterData: false
});
