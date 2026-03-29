param(
    [string]$Folder = ".",                      # Cartella (default = corrente)
    [string]$Extension = "*",                  # Estensione file (*.mkv, *.mp4, *)
    [string]$SeriesName = "Serie",             # Nome serie
    [string]$Season = "01",                    # Stagione (01, 02...)
    [switch]$UseEpisodeFromFile,               # Usa numero episodio dal filename (es: 1x001)
    [string]$EpisodePattern = "\dx(\d{3})",    # Regex per episodio (default 1x001)
    [string]$TitlePattern = "\dx\d{3}\.(.+?)\.Ita", # Regex titolo episodio
    [switch]$Preview                          # Anteprima senza rinominare
)

$files = Get-ChildItem -Path $Folder -Filter $Extension | Sort-Object Name

$episodeCounter = 1

foreach ($file in $files) {

    # Nome base senza estensione
    $base = $file.BaseName

    # Converte punti in spazi
    $cleanName = $base -replace "\.", " "

    # --- Estrazione numero episodio ---
    if ($UseEpisodeFromFile -and ($base -match $EpisodePattern)) {
        $episode = [int]$matches[1]
    } else {
        $episode = $episodeCounter
    }

    $epFormatted = "E" + $episode.ToString("00")
    $seasonFormatted = "S" + $Season.PadLeft(2,'0')

    # --- Estrazione titolo ---
    if ($base -match $TitlePattern) {
        $title = $matches[1] -replace "\.", " "
    } else {
        $title = "Episodio $epFormatted"
    }

    # Pulizia extra (opzionale)
    $title = $title -replace "\s+", " "
    $title = $title.Trim()

    # --- Nome finale ---
    $newName = "$SeriesName - $seasonFormatted$epFormatted - $title$($file.Extension)"

    if ($Preview) {
        Write-Host "$($file.Name)  -->  $newName"
    } else {
        Rename-Item -Path $file.FullName -NewName $newName
    }

    $episodeCounter++
}