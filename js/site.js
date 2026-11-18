// The theme button and the phone's menu, from Silverside's js/site.js. The page works without this
// script: it follows the system appearance, the theme buttons stay hidden, and the menu still opens
// and closes from its button.
(function () {
  var root = document.documentElement;
  var systemLight = window.matchMedia("(prefers-color-scheme: light)");

  // ---------- Theme ----------
  // A choice is kept only while it differs from the system appearance, so the page follows the system
  // again once the two agree.
  function storedTheme() {
    try { return localStorage.getItem("theme"); } catch (e) { return null; }
  }
  function storeTheme(theme) {
    try {
      if (theme) localStorage.setItem("theme", theme); else localStorage.removeItem("theme");
    } catch (e) {}
  }
  function systemTheme() { return systemLight.matches ? "light" : "dark"; }

  // The theme button in the nav, and its twin in the phone's menu.
  var buttons = document.querySelectorAll(".theme-btn");
  function applyTheme(theme) {
    root.dataset.theme = theme;
    var label = theme === "light" ? "Switch to dark appearance" : "Switch to light appearance";
    buttons.forEach(function (button) {
      var text = button.querySelector(".theme-btn__label");
      if (text) text.textContent = theme === "light" ? "Dark appearance" : "Light appearance";
      else button.setAttribute("aria-label", label);
      button.title = label;
    });
  }

  applyTheme(storedTheme() || systemTheme());
  systemLight.addEventListener("change", function () {
    if (!storedTheme()) applyTheme(systemTheme());
  });
  buttons.forEach(function (button) {
    button.hidden = false;
    button.addEventListener("click", function () {
      var next = root.dataset.theme === "light" ? "dark" : "light";
      storeTheme(next === systemTheme() ? null : next);
      applyTheme(next);
    });
  });

  // ---------- Phone menu ----------
  // A link in it, a tap outside it, or Escape closes it.
  var menu = document.querySelector(".nav-menu");
  if (menu) {
    menu.querySelectorAll("a").forEach(function (link) {
      link.addEventListener("click", function () { menu.open = false; });
    });
    document.addEventListener("click", function (event) {
      if (menu.open && !menu.contains(event.target)) menu.open = false;
    });
    document.addEventListener("keydown", function (event) {
      if (event.key === "Escape" && menu.open) { menu.open = false; menu.querySelector("summary").focus(); }
    });
  }
})();
