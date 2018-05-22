// Function.prototype.inherits = function (Parent) {
//   function Surrogate(){}
//   Surrogate.prototype = Parent.prototype;
//   this.prototype = new Surrogate();
//   this.prototype.constructor = this;
// };

Function.prototype.inherits = function (Parent) {
  this.prototype = Object.create(Parent.prototype);
  this.prototype.constructor = this;
};


function MovingObject () {}

function Ship () {}
Ship.inherits(MovingObject);

function Asteroid () {}
Asteroid.inherits(MovingObject);