(function () {
    function ready(callback) {
        if (document.readyState === "loading") {
            document.addEventListener("DOMContentLoaded", callback);
        }
        else {
            callback();
        }
    }

    function normalizeText(text) {
        return String(text || "").replace(/\s+/g, " ").replace(/\u200b/g, "").trim();
    }

    function slugify(text, usedIds) {
        var slug = normalizeText(text).toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "");
        if (!slug) {
            slug = "section";
        }

        var candidate = slug;
        var suffix = 2;
        while (usedIds[candidate] || document.getElementById(candidate)) {
            candidate = slug + "-" + suffix;
            suffix++;
        }

        usedIds[candidate] = true;
        return candidate;
    }

    function headingId(heading, usedIds) {
        var anchor = heading.querySelector("a.anchor[id], a[id]");
        if (anchor && anchor.id) {
            return anchor.id;
        }

        if (heading.id) {
            return heading.id;
        }

        heading.id = slugify(heading.textContent, usedIds);
        return heading.id;
    }

    function buildToc() {
        var content = document.querySelector("#doc-content .contents");
        if (!content) {
            return;
        }

        var headings = Array.prototype.slice.call(content.querySelectorAll("h1, h2, h3, h4"))
            .filter(function (heading) {
                var text = normalizeText(heading.textContent);
                return text && heading.offsetParent !== null;
            })
            .slice(0, 40);

        if (headings.length < 2) {
            return;
        }

        var usedIds = {};
        var aside = document.createElement("aside");
        aside.className = "infineon-page-toc";
        aside.setAttribute("aria-label", "On this page");

        var title = document.createElement("div");
        title.className = "infineon-page-toc-title";
        title.textContent = "On this page";

        var list = document.createElement("ul");
        list.className = "infineon-page-toc-list";

        var links = [];
        headings.forEach(function (heading) {
            var text = normalizeText(heading.textContent);
            var id = headingId(heading, usedIds);
            var level = Math.min(Math.max(parseInt(heading.tagName.slice(1), 10), 1), 4);

            var item = document.createElement("li");
            item.className = "infineon-page-toc-level-" + level;

            var link = document.createElement("a");
            link.className = "infineon-page-toc-link";
            link.href = "#" + id;
            link.textContent = text;

            links.push({ heading: heading, link: link });
            item.appendChild(link);
            list.appendChild(item);
        });

        aside.appendChild(title);
        aside.appendChild(list);
        document.body.appendChild(aside);
        document.body.classList.add("infineon-has-page-toc");

        if ("IntersectionObserver" in window) {
            var observer = new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    if (!entry.isIntersecting) {
                        return;
                    }

                    links.forEach(function (item) { item.link.classList.remove("is-active"); });
                    var match = links.find(function (item) { return item.heading === entry.target; });
                    if (match) {
                        match.link.classList.add("is-active");
                    }
                });
            }, { rootMargin: "-20% 0px -70% 0px", threshold: 0.01 });

            links.forEach(function (item) { observer.observe(item.heading); });
        }
    }

    ready(buildToc);
}());
