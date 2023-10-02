Add-Type -AssemblyName System.Windows.Forms

# 最後に確認されたマウスカーソルの位置を保存。
$lastKnownPosition = [System.Windows.Forms.Cursor]::Position

# 無限ループ。
while ($true) {
    # 3分待機。
    Start-Sleep -Seconds (3 * 60)
    # 現在のマウスカーソルの位置を取得。
    $currentPosition = [System.Windows.Forms.Cursor]::Position
    # マウスカーソルが動いていないか確認。
    if ($lastKnownPosition.Equals($currentPosition)) {
        # マウスカーソルを微妙に動かす。
        [System.Windows.Forms.Cursor]::Position =
        New-Object System.Drawing.Point (
            ($currentPosition.X + 1),
            ($currentPosition.Y + 1))
        # マウスカーソルを元の位置に戻す。
        [System.Windows.Forms.Cursor]::Position = $currentPosition
    }
    # 現在の位置を次のループでの最後に確認された位置として保存。
    $lastKnownPosition = $currentPosition
}
