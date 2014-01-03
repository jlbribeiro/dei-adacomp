DATA = {
  "3 terms": {
    "trimf": {
      "algebraic": {
        "centroid": (86.627, 3.624),
        "bisector": (83.846, 2.199)
      },
      "zadeh": {
        "centroid": (74.824, 0.593),
        "bisector": (74.204, 0.652)
      }
    },
    "gauss": {
      "algebraic": {
        "centroid": (73.220, 0.566),
        "bisector": (85.331, 3.419)
      },
      "zadeh": {
        "centroid": (73.256, 0.612),
        "bisector": (73.377, 0.464)
      }
    }
  },
  "5 terms": {
    "trimf": {
      "algebraic": {
        "centroid": (107.419, 0.790),
        "bisector": (108.633, 1.591)
      },
      "zadeh": {
        "centroid": (103.604, 0.813),
        "bisector": (104.010, 1.747)
      }
    },
    "gauss": {
      "algebraic": {
        "centroid": (100.416, 0.516),
        "bisector": (114.191, 0.947)
      },
      "zadeh": {
        "centroid": (93.625, 0.525),
        "bisector": (106.071, 1.700)
      }
    }
  }
}

def main():
  ROW_TEMPLATE = "{0} & \\texttt{{{1}}} & \\texttt{{{2}}} & \\texttt{{{3}}} & {4} & {5} \\\\\n\\hline"

  for n_terms in ["3 terms", "5 terms"]:
    for functions_type in ["trimf", "gauss"]:
      for operators_set in ["algebraic", "zadeh"]:
        for defuzz_method in ["centroid", "bisector"]:
          mean, std_dev = DATA[n_terms][functions_type][operators_set][defuzz_method]
          print ROW_TEMPLATE.format(n_terms, functions_type, operators_set, defuzz_method, mean, std_dev)

if __name__ == "__main__":
  main()