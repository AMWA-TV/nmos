(() => {
  "use strict";

  const root = document.querySelector("[data-global-search]");
  if (!root) return;

  const input = root.querySelector("[data-global-search-input]");
  const filter = root.querySelector("[data-global-search-filter]");
  const status = root.querySelector("[data-global-search-status]");
  const results = root.querySelector("[data-global-search-results]");
  let documents = [];

  const tokens = value => value.toLocaleLowerCase().match(/[\p{L}\p{N}]+/gu) || [];

  function clearResults() {
    results.replaceChildren();
  }

  function addResult(document, score, query) {
    const item = window.document.createElement("li");
    item.className = "global-search-result";
    const link = window.document.createElement("a");
    link.href = document.url;
    link.textContent = document.title;
    item.appendChild(link);

    const meta = window.document.createElement("p");
    meta.className = "global-search-result-meta";
    meta.textContent = `${document.repository || "AMWA documentation"} · relevance ${score}`;
    item.appendChild(meta);

    const haystack = `${document.title} ${document.text}`;
    const position = haystack.toLocaleLowerCase().indexOf(query.toLocaleLowerCase());
    const start = position < 0 ? 0 : Math.max(0, position - 90);
    const snippet = window.document.createElement("p");
    snippet.textContent = `${start > 0 ? "…" : ""}${haystack.slice(start, start + 240)}${start + 240 < haystack.length ? "…" : ""}`;
    item.appendChild(snippet);
    results.appendChild(item);
  }

  function search() {
    const query = input.value.trim();
    const queryTokens = tokens(query);
    const selectedRepository = filter.value;
    clearResults();

    if (!queryTokens.length) {
      status.textContent = `${documents.length} documents available. Enter a search term.`;
      return;
    }

    const phrase = query.toLocaleLowerCase();
    const matches = documents.flatMap(document => {
      if (selectedRepository && document.repository !== selectedRepository) return [];
      const title = (document.title || "").toLocaleLowerCase();
      const text = (document.text || "").toLocaleLowerCase();
      const haystack = `${title} ${text}`;
      if (!queryTokens.every(token => haystack.includes(token))) return [];

      let score = queryTokens.length;
      if (title.includes(phrase)) score += 100;
      queryTokens.forEach(token => {
        if (title.includes(token)) score += 20;
      });
      return [{ document, score }];
    });

    matches.sort((left, right) => right.score - left.score || left.document.title.localeCompare(right.document.title));
    matches.slice(0, 100).forEach(match => addResult(match.document, match.score, query));
    status.textContent = `${matches.length} result${matches.length === 1 ? "" : "s"}${matches.length > 100 ? " (first 100 shown)" : ""}.`;
  }

  fetch(root.dataset.indexUrl || "../global-search.json")
    .then(response => {
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      return response.json();
    })
    .then(data => {
      documents = Array.isArray(data.documents) ? data.documents : [];
      const repositories = [...new Set(documents.map(document => document.repository).filter(Boolean))].sort();
      repositories.forEach(repository => {
        const option = window.document.createElement("option");
        option.value = repository;
        option.textContent = repository;
        filter.appendChild(option);
      });
      search();
    })
    .catch(error => {
      status.textContent = `The global search index could not be loaded (${error.message}).`;
    });

  input.addEventListener("input", search);
  filter.addEventListener("change", search);
})();
