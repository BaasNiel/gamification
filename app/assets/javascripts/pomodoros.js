(function() {
  var addZeroPadding, convertSecondsToTimer, currentTime, hasFocus, isFocusGained, isResumed, refreshScreen, synchronizeTimer, updateTimerDisplay;

  window.countdownTimerId = null;

  window.lastFocus = true;

  window.lastUpdated = null;

  window.titlePrefix = document.title;

  $(function() {
    if (!$('body').hasClass("rails_pomodoros")) {
      return false;
    }

    var countdownTimerId;
    updateTimerDisplay(window.remainingSeconds);
    if (isCountingDown === "true") {
      return countdownTimerId = setInterval(function() {
        if (window.remainingSeconds > 0) {
          window.remainingSeconds -= 1;
        } else {
          isCountingDown = false;
          clearInterval(countdownTimerId);

          var audio = new Audio(window.audioPath);

          $(audio).off('ended');
          $(audio).on('ended', function() {
            refreshScreen();
          })

          audio.play().catch((error) => {
            console.error(error);
          });
        }
        updateTimerDisplay(window.remainingSeconds);
        if (isFocusGained() === true || isResumed() === true) {
          synchronizeTimer();
        }
        window.lastFocus = hasFocus();
        return window.lastUpdated = currentTime();
      }, 1000);
    }
  });

  isFocusGained = function() {
    return hasFocus() === true && window.lastFocus === false;
  };

  isResumed = function() {
    return currentTime() - window.lastUpdated > 5000;
  };

  currentTime = function() {
    return new Date().getTime();
  };

  hasFocus = function() {
    return window.document.hasFocus();
  };

  synchronizeTimer = function() {
    return $.ajax({
      async: true,
      type: "GET",
      url: "/pomodoros/" + timerId,
      success: function(data, status, xhr) {
        window.remainingSeconds = parseInt(data.remaining_seconds);
        if (window.remainingSeconds <= 0) {
          window.isCountingDown = false;
          return refreshScreen();
        }
      }
    });
  };

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
