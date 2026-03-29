# 📺 Bulk Series Renamer (PowerShell)

Script PowerShell per rinominare automaticamente episodi di serie TV / anime in modo ordinato e uniforme.

---

## 🚀 Features

- Rinominazione in bulk di file
- Supporto numerazione automatica o da filename
- Estrazione titolo episodio tramite regex
- Personalizzabile per qualsiasi serie
- Modalità anteprima (`-Preview`)
- Compatibile con qualsiasi estensione

---

Vai nella cartella:
cd <repo-folder>

⚙️ Utilizzo

Esegui lo script da PowerShell:

.\rename-series.ps1 `
-Extension *.mkv `
-SeriesName "Hunter X Hunter" `
-Season 1 `
-UseEpisodeFromFile `
-Preview

👉 Rimuovi -Preview per applicare le modifiche.
