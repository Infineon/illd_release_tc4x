(function () {
    function currentScriptBase() {
        var scripts = document.getElementsByTagName("script");
        var script = document.currentScript || scripts[scripts.length - 1];
        var source = script && script.src ? script.src : "version-selector.js";
        return source.replace(/version-selector\.js(?:\?.*)?$/, "");
    }

    function normalizeVersion(version) {
        return String(version || "").toLowerCase().replace(/^v/, "");
    }

    function addVersions(manifest) {
        var container = document.getElementById("infineon-version-control");
        var select = document.getElementById("infineon-version-select");
        if (!container || !select) {
            return;
        }

        var versions = Array.isArray(manifest) ? manifest : manifest.versions;
        if (!versions || versions.length === 0) {
            container.style.display = "none";
            return;
        }

        var currentVersion = normalizeVersion(container.getAttribute("data-current-version"));
        var selected = false;

        for (var index = 0; index < versions.length; index++) {
            var version = versions[index];
            var option = document.createElement("option");
            var target = version.url || version.path || "./";
            option.value = target;
            option.text = version.label || version.version || target;

            if (!selected && normalizeVersion(version.version) === currentVersion) {
                option.selected = true;
                selected = true;
            }

            select.appendChild(option);
        }

        select.addEventListener("change", function () {
            if (select.value) {
                window.location.href = new URL(select.value, window.location.href).href;
            }
        });
    }

    function loadVersions() {
        var manifestUrl = currentScriptBase() + "versions.json";
        fetch(manifestUrl, { cache: "no-cache" })
            .then(function (response) {
                if (!response.ok) {
                    throw new Error("Could not load " + manifestUrl);
                }

                return response.json();
            })
            .then(addVersions)
            .catch(function () {
                var container = document.getElementById("infineon-version-control");
                if (container) {
                    container.style.display = "none";
                }
            });
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", loadVersions);
    }
    else {
        loadVersions();
    }
}());
