const View = require("./ttt-view");
const Game = require("./game")

$( () => {
  // Your code here
  const el = $('.ttt');
  const game = new Game();
  const view = new View(game,el)
});
