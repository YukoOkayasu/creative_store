$(document).on('turbolinks:load', function() {
  //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
  $('#myImage').on('change', function(e) {
    var $file = e.target.files[0],
        reader = new FileReader(),
        $preview = $(".preview");
        t = this;
    // 画像ファイル以外の場合は何もしない
    if($file.type.indexOf("image") < 0){
      alert("画像ファイルを選択してください")
    }

    // ファイル読み込みが完了した際のイベント登録
    reader.onload = (function(file) {
      return function(e) {
        //既存のプレビューを削除
        $preview.empty();
        // .prevewの領域の中にロードした画像を表示するimageタグを追加
        $preview.attr({
                  src: e.target.result,
                  width: "200px",
                  height: "200px",
                  class: "preview",
                  title: $file.name
        });
      };
    })($file);

    reader.readAsDataURL($file);
  });
});
