/**
 * This file re-uses a lot of logic from pomodoros.js. It might be a good
 * idea to find a way to reuse the logic between files. If you change something
 * here, you most likely would need to change it in pomodoros.js too
**/
(function() {
  $(function() {
    $('.team__remaining-seconds').each(function() {
      var remainingSeconds = parseInt($(this).text());
      var remainingMs = remainingSeconds * 1000;
      tick(Date.now(), 0, this, remainingMs);
    });
  });

  function tick(startTimestamp, elapsedMs, element, remainingMs) {
    updateTimerDisplay(element, (remainingMs - elapsedMs)/1000);

    if (elapsedMs >= remainingMs) {
      return location.reload();
    }

    var inaccuracy = (Date.now() - startTimestamp) - elapsedMs;
    var nextTickSize = 1000 - inaccuracy;

    setTimeout(tick,
      nextTickSize,
      startTimestamp,
      elapsedMs + 1000,
      element,
      remainingMs
    )
  }

  function updateTimerDisplay(element, remainingSeconds) {
    var timerString;
    timerString = convertSecondsToTimer(remainingSeconds);
    $(element).text(timerString);
  }

  function convertSecondsToTimer(count) {
    var minutes, seconds;
    minutes = Math.floor(count / 60);
    seconds = count % 60;
    return addZeroPadding(minutes) + ":" + addZeroPadding(seconds);
  }

  function addZeroPadding(number) {
    var string;
    string = "00" + String(number);
    return string.substr(string.length - 2);
  }
}).call(this);
