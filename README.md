# anti-idle

Windowsで一定時間カーソルの移動がない場合自動的にカーソルを動かして元に戻すプログラムです。

自宅でデスクトップを使っているのにラップトップ向けの理不尽なポリシーが適応された場合の防衛術と考えています。

# スタートアップ時にバックグラウンドで自動起動する方法

`shell:startup`フォルダを開いて新規作成でショートカットを選択します。

場所を、

~~~
conhost --headless powershell.exe -NoProfile -WindowStyle Hidden -NonInteractive -File %USERPROFILE%\Desktop\anti-idle\AntiIdle.ps1
~~~

と設定します。

Desktop以下に`git clone`なりで配置していることを前提にしています。
そうじゃない場合は`-File`で指定している場所は読み替えてください。

ショートカットの名前は何でも良いですが、私は`AntiIdle`としています。
