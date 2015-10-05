- Number of columns in the given matrix
  * columns (a)
  * size(a, 2)

- Number of rows in the given matrix
  * rows(a)
  * size(a, 1)

- Compute e^x for each element of x
  * exp (x)

- Comute log for each element of x
  * log (x)

- for loop
  * for i = 1:size(x,1)

       //do something

     end;

     more - https://www.gnu.org/software/octave/doc/interpreter/The-for-Statement.html

- if condition
  * if(x(1,1)==5)

        //do something

    end;

    more - https://www.gnu.org/software/octave/doc/interpreter/The-if-Statement.html
         - https://en.wikibooks.org/wiki/Octave_Programming_Tutorial/Loops_and_conditions

- Compute max row-wise and return index and number itself
  * [num, index] = max(A, [], 2);

  - Size of a column in a matrix
  * size(A, 2);


- Add a column before matrix
  * b = [ones(3,1) b]

>e.g.

    b = rand(3, 2)

    0.366929   0.970706
    0.071782   0.715650
    0.777319   0.890047

    b = [ones(3,1) b]

    1.000000   0.366929   0.970706
    1.000000   0.071782   0.715650  
    1.000000   0.777319   0.890047

- Calculating column-wise sum
   * sum(A)

>e.g.

    a = rand(3,3)
    a =
    0.023672   0.054616   0.824755
    0.583748   0.509149   0.299189
    0.985315   0.111292   0.210155

    sum(a)
    ans =
    1.59273   0.67506   1.33410

- To compare to strings
  * strcmp(str, vocabList{i})

- To calculate norm
  * norm(x1-x2)^2
