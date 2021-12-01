# Advent of Code 2021

My solutions to [Advent of Code](https://adventofcode.com/2021) for 2021.

## Development environment

The repository includes config for a [VS Code Dev Container](https://code.visualstudio.com/docs/remote/create-dev-container/).

1. Install Docker Desktop
2. Open project in VS Code.
3. Press F1, and choose `Remote-Containers: Reopen in Container...`
4. Open a VS Code terminal in the container via the `Terminal > New Terminal` menu option
5. Run the solutions or tests using the commands shown below

## Running the solutions

Each of the two daily puzzle parts have their own Mix tasks, which can be run as shown below. The example shows how to run the second part of day one's puzzle.

```
$ mix d01.p2
```

## Running the tests

Running the project's tests can be done with the normal `mix test` command.

Tests for each day are tagged so that tests for a single day can be run like this:

```
mix test --only day01
```

## Credits

Project structure based on [Advent of Code Elixir Starter](https://github.com/mhanberg/advent-of-code-elixir-starter).
