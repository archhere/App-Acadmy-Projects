class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
    this.$el.on("click", "li", event => {
      let $square = $(event.currentTarget);
      this.makeMove($square);
    });
  }

  makeMove($square) {
    let pos = $square.data("pos")
    let currentPlayer = this.game.currentPlayer;
    try{
      this.game.playMove(pos);
    } catch (e) {
      alert("This " + e.msg);
      return;
    }
    $square.addClass(currentPlayer);

    if (this.game.isOver()){
      this.el.off("click");
      this.el.addClass("gameover");
      const winner = this.game.winner();
      const $figcaption = $("<figcaption>")
      if(winner){
        this.$el.addClass('winner-'+ winner)
        $figcaption.html("you win"+winner);
        }
        else $figcaption.html("Its a draw")
        this.$el.append($figcaption);
      }
    }


  setupBoard() {

  let $ul = $("<ul>");
  for(let i=0; i<3; i++){
    for(let j=0; j<3; j++){
      let $li = $("<li>");
      $li.data("pos",[i,j]);
      $ul.append($li);
    }

  }
  this.$el.append($ul)
  }

}

module.exports = View;
