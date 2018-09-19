/**
 * This file uses a lot of logic from team.js. It might be a good
 * idea to find a way to reuse the logic between files. If you change something
 * here, you most likely would need to change it in team.js too
**/

(function() {
  var addZeroPadding, convertSecondsToTimer, updateTimerDisplay;

  window.titlePrefix = document.title;

  var remainingMs = 0;
  var notificationSound = new Audio();

  $(function() {
    /**
    * This is here because I'm a bad coder. The file is included on every
    * page, so basically I am just checking if we're on the pomodoro page. If
    * not, we just return out of the function.
    */
    if (!$('body').hasClass("rails_pomodoros")) {
      return false;
    }

    if (Notification.permission === 'default') {
      /**
      * Request notification permission if it hasn't been explicitly granted or
      * denied.
      */
      Notification.requestPermission();
    }

    notificationSound.src = window.audioPath;
  });

  window.startCountdown = function(remainingSeconds) {
    remainingMs = remainingSeconds * 1000;
    tick(Date.now(), 0);
  }

  tick = function(startTimestamp, elapsedMs) {
    updateTimerDisplay((remainingMs - elapsedMs)/1000);

    if (elapsedMs >= remainingMs) {
      stopCountdown();
      return;
    }

    var inaccuracy = (Date.now() - startTimestamp) - elapsedMs;
    var nextTickSize = 1000 - inaccuracy;

    setTimeout(tick,
      nextTickSize,
      startTimestamp,
      elapsedMs + 1000)
  }

  function stopCountdown () {
    if (Notification.permission === 'granted') {
      new Notification("It's time to stop!")
    }

    $(notificationSound).on('ended', function() {
      refreshScreen();
    })

    notificationSound.play();
  }

  refreshScreen = function() {
    return location.reload();
  };

  updateTimerDisplay = function(remainingSeconds) {
    var timerString;
    timerString = convertSecondsToTimer(remainingSeconds);
    $("#pomodoro-time").text(timerString);
    return document.title = window.titlePrefix + " (" + timerString + ")";
  };

  convertSecondsToTimer = function(count) {
    var minutes, seconds;
    minutes = Math.floor(count / 60);
    seconds = count % 60;
    return addZeroPadding(minutes) + ":" + addZeroPadding(seconds);
  };

  addZeroPadding = function(number) {
    var string;
    string = "00" + String(number);
    return string.substr(string.length - 2);
  };

}).call(this);
