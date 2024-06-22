<script lang="ts">

  import { Move } from "./game-type";

  let initialSquares = new Array(9).fill(null);
  let userTurn = Move.PlayerOne;
  let squares = [ ...initialSquares ];

  let winnerMsg = null;
  function restart() {
	userTurn = Move.PlayerOne;
	squares = [ ...initialSquares ];
	winnerMsg = null;
  }
  function handleClick(i) {
	if (!squares[i] && !winnerMsg) {
	  squares[i] = userTurn;
	  userTurn === Move.PlayerOne
	  ? userTurn = Move.PlayerTwo
	  : userTurn = Move.PlayerOne;
	  winnerMsg = winingPositions(squares);
	  if (winnerMsg)
		userTurn = Move.PlayerOne;
	}
  }
  function winingPositions(squares) {
	const winningCombs = [
	  [ 0, 1, 2 ],
	  [ 3, 4, 5 ],
	  [ 6, 7, 8 ],
	  [ 0, 3, 6 ],
	  [ 1, 4, 7 ],
	  [ 2, 5, 8 ],
	  [ 0, 4, 8 ],
	  [ 2, 4, 6 ]
	];
	for (let i = 0; i < winningCombs.length; i++) {
	  const [ a, b, c ] = winningCombs[i];
	  if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
		// console.log(`Winner: ${squares[a]?.toUpperCase()}`)
		return `Winner: ${squares[a] !== Move.PlayerOne
						  ? "Blue"
						  : "Red"} player`;
	  }
	}
	const isDraw = squares.every(square => !!square);
	if (isDraw) return isDraw
					   ? "It's a draw"
					   : null;
  }
</script>
<main class="flex flex-col">
  <div>
	{#if winnerMsg}
	  {#if winnerMsg == "It's a draw"}
		<div class="bg-cyan-600 text-center py-4 lg:px-4 w-3/4 m-auto mt-2 rounded">
		  <div
			class="p-2 bg-cyan-600 items-center text-teal-100 leading-none lg:rounded-full flex lg:inline-flex"
			role="alert">
			<span class="font-semibold mr-2 text-left flex-auto text-center">{winnerMsg}</span>
		  </div>
		</div>
	  {:else}
		<div class="bg-teal-500 text-center py-4 lg:px-4 w-3/4 m-auto mt-2 rounded">
		  <div
			class="p-2 bg-teal-600 items-center text-teal-100 leading-none lg:rounded-full flex lg:inline-flex"
			role="alert">
			<span class="font-semibold mr-2 flex-auto text-center">{winnerMsg}</span>
		  </div>
		</div>
	  {/if}
	  <div>

	  </div>
	{:else}
	  <div
		class:bg-indigo-400={ userTurn !== Move.PlayerOne }
		class:bg-rose-400={ userTurn !== Move.PlayerTwo }
		class="text-center py-4 lg:px-4 w-3/4 m-auto mt-2 rounded">
		<div
		  class:bg-indigo-500={ userTurn !== Move.PlayerOne }
		  class:bg-rose-500={ userTurn !== Move.PlayerTwo }
		  class="p-2 items-center text-teal-100 leading-none lg:rounded-full flex lg:inline-flex"
		  role="alert">
		  <span class="font-semibold mr-2 flex-auto text-center">
			Next Player : {userTurn !== Move.PlayerOne ? "blue" : "red"}
		  </span>
		</div>
	  </div>
	{/if}</div>

  <div class="{!!userTurn ? userTurn + ' game' : 'game'} p-8">
	{#each squares as square, i}
	  <div
		class={!!square ? square + ' tile' : 'tile'} on:click={() => handleClick(i)}></div>
	{/each}
  </div>
  <button
	class="mx-auto bg-transparent
		hover:bg-blue-500 text-blue-700 font-semibold
		hover:text-white py-2 px-4 border border-blue-500
		hover:border-transparent rounded" on:click={restart}>Restart Game
  </button>
</main>
<style>
  :root {
  }

  .game {
	display: grid;
	justify-content: center;
	justify-items: center;
	align-content: center;
	align-items: center;
	grid-template-columns: repeat(3, auto);
  }

  .tile {
	width: 120px;
	height: 120px;
	border: 1px solid slateblue;
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
	cursor: pointer;
  }

  .tile:first-child,
  .tile:nth-child(2),
  .tile:nth-child(3) {
	border-top: none;
  }

  .tile:nth-child(3n + 1) {
	border-left: none;
  }

  .tile:nth-child(3n + 3) {
	border-right: none;
  }

  .tile:nth-child(7),
  .tile:nth-child(8),
  .tile:nth-child(9) {
	border-bottom: none;
  }

  .tile.X,
  .tile.O {
	cursor: not-allowed;
  }

  .tile.X::before,
  .tile.X::after {
	background-color: hotpink;
  }

  .tile.O::before,
  .tile.O::after {
	background-color: cornflowerblue;
  }

  .game.X .tile:not(.X):not(.O):hover::before,
  .game.X .tile:not(.X):not(.O):hover::after,
  .game.O .tile:not(.X):not(.O):hover::before {
	background-color: lightgrey;
  }

  .tile.X::before,
  .tile.X::after,
  .game.X .tile:not(.X):not(.O):hover::before,
  .game.X .tile:not(.X):not(.O):hover::after {
	content: "";
	position: absolute;
	width: calc(50px * 0.15);
	height: 50px;
  }

  .tile.X::before,
  .game.X .tile:not(.X):not(.O):hover::before {
	transform: rotate(50deg);
  }

  .tile.X::after,
  .game.X .tile:not(.X):not(.O):hover::after {
	transform: rotate(-20deg);
  }

  .tile.O::before,
  .tile.O::after,
  .game.O .tile:not(.X):not(.O):hover::before,
  .game.O .tile:not(.X):not(.O):hover::after {
	content: "";
	position: absolute;
	border-radius: 35%;
  }

  .tile.O::before,
  .game.O .tile:not(.X):not(.O):hover::before {
	width: 50px;
	height: 50px;
  }

  .tile.O::after,
  .game.O .tile:not(.X):not(.O):hover::after {
	width: calc(50px * 0.7);
	height: calc(50px * 0.7);
	background-color: white;
  }

  h1 {
	text-align: center;
	text-decoration: underline;
	text-decoration-color: red;
	margin: 2rem;
	padding: 1rem;
  }

</style>