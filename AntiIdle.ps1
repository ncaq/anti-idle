Add-Type -AssemblyName System.Windows.Forms

# 最後に確認されたマウスカーソルの位置を保存。
$lastKnownPosition = [System.Windows.Forms.Cursor]::Position

$user32_mouse_event_signature = @"
[DllImport("user32.dll", CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
"@

$MouseEvent =
Add-Type -MemberDefinition $user32_mouse_event_signature -Name "MouseEvent" -Namespace Win32Functions -PassThru

# 無限ループ。
while ($true) {
    # 2分待機。
    Start-Sleep -Seconds (2 * 60)
    # 現在のカーソルの位置を取得。
    $currentPosition = [System.Windows.Forms.Cursor]::Position
    # カーソルが動いていないか確認。
    if ($lastKnownPosition.Equals($currentPosition)) {
        # アイドル状態が続いているかもしれないことを確認。
        # 少なくともカーソルは動いていないので、カーソルを動かしても害は無さそう。
        Write-Host "Recognized as idle."

        # 座標を設定することでカーソルを動かす。
        [System.Windows.Forms.Cursor]::Position =
        New-Object System.Drawing.Point (
            ($currentPosition.X + 1),
            ($currentPosition.Y + 1))
        [System.Windows.Forms.Cursor]::Position = $currentPosition

        # イベントを発生することでカーソルを動かす。
        $MouseEvent::mouse_event(0x0001, 1, 1, 0, 0)
        $MouseEvent::mouse_event(0x0001, -1, -1, 0, 0)
    }
    else {
        Write-Host "Recognized as not idle."
    }
    # 現在の位置を次のループでの最後に確認された位置として保存。
    $lastKnownPosition = $currentPosition
}
