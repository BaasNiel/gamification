// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require bootstrap
//= require jquery.slimscroll
//= require waves
//= require sidebarmenu
//= require_self
//= require users
//= require achievements
//= require profile
//= require pomodoros
//= require team
//
//= require_tree ./channels
//
//= require chartist.min
//= require chartist-plugin-tooltip
//= require jquery.sparkline.min
//= require jquery.charts-sparkline
//= require jquery.knob
//= require jquery.easypiechart
//= require moment


$(function() {

  "use strict";

  /* ========== Disabling Preloader ========== */

  $(".preloader").fadeOut('slow');

  /* ========== Changes Takes Place On Body Resize Event ========== */

  var set = function() {
      var width = (window.innerWidth > 0) ? window.innerWidth : this.screen.width;
      var topOffset = 60;
      if (width < 1170) {
          $("body").addClass("mini-sidebar");
          $('.top-left-part span').hide();

          $(".sidebartoggler i").addClass("fa fa-bars");
      } else {
          $("body").removeClass("mini-sidebar");
          $('.top-left-part span').show();
          $(".sidebartoggler i").removeClass("fa fa-bars");
      }

      var height = ((window.innerHeight > 0) ? window.innerHeight : this.screen.height) - 1;
      height = height - topOffset;
      if (height < 1) height = 1;
      if (height > topOffset) {
          $(".page-wrapper").css("min-height", (height) + "px");
      }

  };
  $(window).ready(set);
  $(window).on("resize", set);

  /* ========== Theme Options ========== */

  $(".sidebartoggler").on('click', function() {
      if ($("body").hasClass("mini-sidebar")) {
          $("body").trigger("resize");

          $("body").removeClass("mini-sidebar");
          $('.top-left-part span').show();
          $(".sidebartoggler i").addClass("fa fa-bars");
      } else {
          $("body").trigger("resize");

          $("body").addClass("mini-sidebar");
          $('.top-left-part span').hide();
          $(".sidebartoggler i").removeClass("fa fa-bars");
      }
  });

  /* ========== this is for close icon when navigation open in mobile view ========== */

  $(".navbar-toggle").on('click', function() {
      $("body").toggleClass("show-sidebar");
      $(".navbar-toggle i").toggleClass("fa-bars");
      $(".navbar-toggle i").addClass("fa-close");
  });
  $(".sidebartoggler").on('click', function() {
      $(".sidebartoggler i").toggleClass("fa fa-bars");
  });

  /* ========== Auto Select Left Navbar ========== */

  $(function() {
      var url = window.location;
      var element = $('ul#side-menu a').filter(function() {
          return this.href == url;
      }).addClass('active').parent().addClass('active');
      while (true) {
          if (element.is('li')) {
              element = element.parent().addClass('in').parent().addClass('active');
          } else {
              break;
          }
      }
  });

  /* ========== Right sidebar options ========== */

  $(".right-side-toggler").on('click', function() {
      $(".right-sidebar").slideDown(50);
      $(".right-sidebar").toggleClass("shw-rside");
  });

  /* ========== Initializing Sidebar Menu ========== */

  $(function() {
      $('#side-menu').metisMenu();
  });

});

/* ========== Collapsible Panels JS ========== */

(function($, window, document) {
  var panelSelector = '[data-perform="panel-collapse"]',
      panelRemover = '[data-perform="panel-dismiss"]';
  $(panelSelector).each(function() {
      var collapseOpts = {
              toggle: false
          },
          parent = $(this).closest('.panel'),
          wrapper = parent.find('.panel-wrapper'),
          child = $(this).children('i');
      if (!wrapper.length) {
          wrapper = parent.children('.panel-heading').nextAll().wrapAll('<div/>').parent().addClass('panel-wrapper');
          collapseOpts = {};
      }
      wrapper.collapse(collapseOpts).on('hide.bs.collapse', function() {
          child.removeClass('ti-minus').addClass('ti-plus');
      }).on('show.bs.collapse', function() {
          child.removeClass('ti-plus').addClass('ti-minus');
      });
  });

  /* ========== Collapse Panels ========== */

  $(document).on('click', panelSelector, function(e) {
      e.preventDefault();
      var parent = $(this).closest('.panel'),
          wrapper = parent.find('.panel-wrapper');
      wrapper.collapse('toggle');
  });

  /* ========== Remove Panels ========== */

  $(document).on('click', panelRemover, function(e) {
      e.preventDefault();
      var removeParent = $(this).closest('.panel');

      function removeElement() {
          var col = removeParent.parent();
          removeParent.remove();
          col.filter(function() {
              return ($(this).is('[class*="col-"]') && $(this).children('*').length === 0);
          }).remove();
      }
      removeElement();
  });
}(jQuery, window, document));

/* ========== Tooltip Initialization ========== */

$(function() {
  $('[data-toggle="tooltip"]').tooltip();
});

/* ========== Popover Initialization ========== */

$(function() {
  $('[data-toggle="popover"]').popover();
});

/* ========== Login and Recover Password ========== */

$('#to-recover').on("click", function() {
  $("#loginform").slideUp();
  $("#recoverform").fadeIn();
});

// Sidebar

$('.slimscrollright').slimScroll({
  height: '100%',
  position: 'right',
  size: "5px",
  color: '#dcdcdc',
});

$('.chat-list').slimScroll({
  height: '100%',
  position: 'right',
  size: "5px",
  color: '#dcdcdc',
});

// Resize all elements

$(window).on('load', function() {
  $("body").trigger("resize");
});
$("body").trigger("resize");

// visited ul li

$('.visited li a').on('click', function(e) {
  $('.visited li').removeClass('active');
  var $parent = $(this).parent();
  if (!$parent.hasClass('active')) {
      $parent.addClass('active');
  }
  e.preventDefault();
});

/* ========== Close notifications =========== */
$(function() {
  $(".myadmin-alert .closed").on("click", function(event) {
    event.preventDefault();
    $(this).parents(".myadmin-alert").fadeToggle(350);
    return false;
  });
});
