#!/usr/bin/env python

def main():
  variables = {}

  ## vvv MODIFY vvv
  # algebraic/zadeh
  and_or_method = "algebraic"

  # centroid/bisector
  variables["DEFUZZ_METHOD"] = "bisector"

  # trimf/gauss
  functions_type = "gauss"
  functions_n_terms = 5
  ## ^^^ MODIFY ^^^

  if and_or_method == "zadeh":
    variables["AND_METHOD"] = "min"
    variables["OR_METHOD"] = "max"

    variables["IMP_METHOD"] = "min"
    variables["AGG_METHOD"] = "max"

  elif and_or_method == "algebraic":
    variables["AND_METHOD"] = "prod"
    variables["OR_METHOD"] = "probor"

    variables["IMP_METHOD"] = "prod"
    variables["AGG_METHOD"] = "sum" # probor?

  else:
    print "Invalid and_or_method."
    return

  variables["CONTROLLER_NAME"] = "{0}{1}_{2}_{3}".format(functions_type, functions_n_terms, and_or_method, variables["DEFUZZ_METHOD"])

  ## Template replace
  functions_file = "controller_templates/{0}{1}.fis.tpl".format(functions_type, functions_n_terms)
  with open(functions_file, "r") as f:
    variables["FUNCTIONS"] = f.read()

  # 9/25
  variables["N_RULES"] = functions_n_terms ** 2

  rules_file = "controller_templates/rules{0}.fis.tpl".format(functions_n_terms)
  with open(rules_file, "r") as f:
    variables["RULES"] = f.read()

  base_file = "controller_templates/base.fis.tpl"
  with open(base_file, "r") as f:
    BASE_TEMPLATE = f.read()

  controller = BASE_TEMPLATE.format(**variables)

  with open("controller.fis", "w") as f:
    f.write(controller)
    print variables["CONTROLLER_NAME"] + " was generated."

if __name__ == "__main__":
  main()