# jobsorter

## Install
  Clone the repo:
  ```bash
  git clone https://github.com/tomdracz/jobsorter.git
  ```

  Run bundle install from the project folder to install rspec:
  ```bash
  bundle install
  ```

## Running script
  Load the library
  ```bash
  require './lib/jobs_sorter.rb'
  ```
  Initialize new JobsSorter object passing jobs string
  ```bash
  jobs_sorter = JobsSorter.new("jobs_string_here")
  ```
  Run the sort method to see an array of ordered jobs
  ```bash
  jobs_sorter.sort
  ```

## Running tests

  From the project directory:

  ```bash
  rspec
  ```


## Notes on the implementation

The problem presented below can be considered an example of topological sorting, hence the existing TSort Ruby standard lib has been used by opening the Hash class to implement tsort there. Using TSort lib is a quick and easy solution and offers things like detecting cyclic dependecies out of the box

## Description of the problem

Imagine we have a list of jobs, each represented by a character. Because certain jobs must be done before others, a job may have a dependency on another job. For example, a may depend on b, meaning the final sequence of jobs should place b before a. If a has no dependency, the position of a in the final sequence does not matter.

+ Given you’re passed an empty string (no jobs), the result should be an empty sequence.

+ Given the following job structure:

   **a =>**

  The result should be a sequence consisting of a single job a.

+ Given the following job structure:

   **a =>**

   **b =>**

   **c =>**

  The result should be a sequence containing all three jobs abc in no significant order.

+ Given the following job structure:

   **a =>**

   **b => c**

   **c =>**

  The result should be a sequence that positions c before b, containing all three jobs abc.

+ Given the following job structure:

   **a =>**

   **b => c**

   **c => f**

   **d => a**

   **e => b**

   **f =>**

  The result should be a sequence that positions f before c, c before b, b before e and a before d containing all six jobs abcdef.

+ Given the following job structure:

   **a =>**

   **b =>**

   **c => c**

  The result should be an error stating that jobs can’t depend on themselves.

+ Given the following job structure:

   **a =>**

   **b => c**

   **c => f**

   **d => a**

   **e =>**

   **f => b**

  The result should be an error stating that jobs can’t have circular dependencies.