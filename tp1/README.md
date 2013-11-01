# Work 1: Symbol recognition using a Linear Associative Memory and a Perceptron
Individual datasets for each digit are provided: this allows the user to define the aspect of each ideal character.

## How to setup the workspace
In order to use the neural networks, a unique dataset must be created from the individual digit datasets. After the assembly of the dataset, it must be split into a training and a validation dataset.

Run `workspace_setup` to generate `P_train.dat` and `P_valid.dat`. Alternatively, use `dataset_digit_merger` to generate the unique dataset and `dataset_train_valid_split` to split it into the training/validation datasets.

## How to train the neural networks
Run `nn_train` to train a Linear Associative Memory and a Perceptron using `P_train.dat`.

## How to validate the neural networks
Run `nn_sim` to train a Linear Associative Memory and a Perceptron using `P_valid.dat`.

## How to test the neural network using the output of `mpaper` (`P.dat`)
Run `tp1` after putting a `P.dat` file (or generating one using `mpaper`) on the current folder.