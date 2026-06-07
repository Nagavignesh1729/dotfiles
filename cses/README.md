# CSES / Competitive Programming workspace

Problem set:  https://cses.fi/problemset/   (start with "Introductory Problems")
Handbook:     https://cses.fi/book/book.pdf  (free, by the CSES author)

## Workflow
1. Pick a problem on cses.fi.
2. Scaffold it:           cpnew weird_algorithm        # C++  (or: cpnew weird_algorithm py)
   -> opens solution + <name>.in side-by-side in nvim (Ctrl-l / Ctrl-h to switch panes)
3. Paste the problem's SAMPLE INPUT into <name>.in (right pane). Write code in the left pane.
4. Test locally:          cprun ~/cses/weird_algorithm.cpp ~/cses/weird_algorithm.in
   -> compare output to the problem's sample output.
5. When it matches, SUBMIT on cses.fi (upload the .cpp / .py file). CSES has no CLI.

## Notes
- CSES time limits favor C++. Python is fine for Introductory problems; switch to C++ as
  problems get heavier (TLE).
- cprun: .cpp -> compiled with `g++ -O2 -std=gnu++20`; .py -> run with python.
- Templates: template.cpp (fast IO + macros), template.py (fast stdin).
