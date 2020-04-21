// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require Chart.min
//= require jquery
//= require jquery_ujs
//= require jquery3
//= require popper
//= require spectrum
//= require bootstrap-sprockets
//= require_tree .


// StudyLog #new
// tagを必須入力にする処理
$(document).on('turbolinks:load', function() {
  $('#study_log_study_log_details_attributes_0_tag_list').change(function(){
    if($(this).val()) {
      // tagが入力されている状態
      $('#regist-button').prop("disabled", false)
    } else {
      // tagが入力されてない状態
      $('#regist-button').prop("disabled", true)
    }
  })
})

// Admin/Tags #edit
// グラフの色をカラーピッカーで選択するための処理
$(document).on('turbolinks:load', function() {
    $("#picker").spectrum({
        color: gon.color, // 初期値
        flat: false, // trueの場合、クリックしなくてもピッカーが表示されるようにする
        showInput: true, // コードの入力欄を表示する
        showAlpha: true, // 不透明度の選択バーを表示する
        disabled: false, // trueの場合、ピッカーを無効にする
        showPalette: true, // パレットを表示する
        showPaletteOnly: false, // true の場合、パレットのみの表示にする
        togglePaletteOnly: false, // true の場合、パレット以外の部分はボタンで表示切替する
        togglePaletteMoreText: "詳細", // togglePaletteOnlyがtrueの場合のボタン名(開く)
        togglePaletteLessText: "閉じる", // togglePaletteOnlyがtrueの場合のボタン名(閉じる)
        showSelectionPalette: true, // ユーザーが前に選択した色をパレットに表示する
        maxSelectionSize: 10, // 選択した色を記憶する数の上限
        hideAfterPaletteSelect: false, // true の場合、パレットを選んだ時点でピッカーを閉じる
        clickoutFiresChange: true, // ピッカーの外側をクリックしてピッカーを閉じた際にchangeイベントを発生させる
        showInitial: true, // 初期の色と選択した色を見比べるエリアを表示する
        allowEmpty: true, // 「指定なし」を許可する
        chooseText: "OK", // 選択ボタンのテキスト
        cancelText: "キャンセル", // キャンセルボタンのテキスト
        showButtons: true, // ボタンを表示する
        containerClassName: "full-spectrum", // ピッカーの部品を囲うタグ(要素)のクラス名
        replacerClassName: "", // ピッカーを表示させるボタンのクラス名
        preferredFormat: "hex", // カラーコードの形式を指定したものに変更する (可能な限り。hex, hex3等)
        localStorageKey: "spectrum.demo", // localStorageに選択色を記憶する際のキー
        palette: [
            ["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
            ["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
            ["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
            ["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
            ["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
            ["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
            ["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
            ["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
        ], // パレット
        selectionPalette: [] // 選択色のパレットの初期値
    });
});