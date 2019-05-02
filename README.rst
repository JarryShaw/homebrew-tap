=======================================================
Homebrew Tap for Jarry Shaw's Productions & Collections
=======================================================

-----
Usage
-----

Use the following commands to add this tap to your local
Homebrew installation.

.. code:: bash

    $ brew tap jarryshaw/tap
    $ brew tap-pin jarryshaw/tap
    # to install MacDaily
    $ brew install macdaily

The |tappin|_ is necessary since mas is already included
in the core tap of Homebrew. A pinned tap's formulae take
precedence over duplicates in other taps.

.. |tappin| replace:: ``tap-pin`` command
.. _tappin: https://docs.brew.sh/Taps#formula-duplicate-names

You can review the repositories you have tapped and pinned
using the following commands.

.. code:: bash

    $ brew tap
    caskroom/cask
    jarryshaw/tap
    $ brew tap --list-pinned
    jarryshaw/tap

If you want to switch back to the core mas formula,
you can unpin this tap.

.. code:: bash

    $ brew tap-unpin jarryshaw/tap

-------
Formula
-------

Productions
-----------

- |macdaily|_: Package day-care manager on macOS.
- |f2format|_: Back-port compiler for Python 3.6 f-string literals.
- |askpass|_: AskPass Utility for macOS
- |confirm|_: Confirm Utility for macOS

.. |macdaily| replace:: ``MacDaily``
.. _macdaily: https://github.com/JarryShaw/MacDaily#macdaily
.. |f2format| replace:: ``f2format``
.. _f2format: https://github.com/JarryShaw/f2format#f2format
.. |askpass| replace:: ``AskPass``
.. _askpass: https://github.com/JarryShaw/askpass#askpass
.. |confirm| replace:: ``Confirm``
.. _confirm: https://github.com/JarryShaw/confirm#confirm

Collections
-----------

- |docutils|_: text processing system for ``reStructuredText``

  This formula is included in Homebrew core repository. However,
  no dependencies, such as ``lxml``, ``Pillow`` and ``Pygments``
  are integrated. See
  `Homebrew/homebrew-core#35209 <https://github.com/Homebrew/homebrew-core/pull/35209>`__.

- |vermin|_: concurrently detect the minimum Python versions needed to run code

  This formula is not notable enough to be included in Homebrew
  core repository yet. See
  `Homebrew/homebrew-core#35633 <https://github.com/Homebrew/homebrew-core/pull/35633>`__.

- |sloc|_: simple tool to count source lines of code

  This formula is now included in Homebrew core repository. See
  `Homebrew/homebrew-core#35632 <https://github.com/Homebrew/homebrew-core/pull/35632>`__.

- |pkt2flow|_ : simple utility to classify packets into flows

  This formula is not notable enough to be included in Homebrew
  core repository yet (<30 forks, <30 watchers and <75 stars).

- |bpython|_ : fancy curses interface to the Python interactive interpreter

  For Python 3 interpreter, the formula is ``bpython``;
  for Python 2 interpreter, the formula is ``bpython@2``.

- |ptpython|_ : better Python REPL

  For Python 3 interpreter, the formula is ``ptpython``;
  for Python 2 interpreter, the formula is ``ptpython@2``.

- |poet|_ : generates Homebrew resource stanzas for Python packages

  This formula is not notable enough to be included in Homebrew
  core repository yet (<30 forks, <30 watchers and <75 stars).
  For Python 3 interpreter, the formula is ``poet``;
  for Python 2 interpreter, the formula is ``poet@2``.

- |uti|_ : CLI tool for interacting with File Type Identifiers on Mac

  This formula is not notable enough to be included in Homebrew
  core repository yet (<30 forks, <30 watchers and <75 stars).

- |ssh-askpass|_ : SSH-Askpass util for MacOS

  This formula is not notable enough to be included in Homebrew
  core repository yet (<30 forks, <30 watchers and <75 stars).

- |noob|_ : generate Homebrew formulae for npm packages

  This formula is not notable enough to be included in Homebrew
  core repository yet (<30 forks, <30 watchers and <75 stars).

- |bro-pkg|_ : package manager for Zeek

  This formula is not notable enough to be included in Homebrew
  core repository yet (<30 forks, <30 watchers and <75 stars).

- |sphinx|_ : Tool to create intelligent and beautiful documentation

  This formula is a port of ``sphinx-doc`` from Homebrew core repository,
  which integrates ``sphinx`` and ``sphinx-autobuild`` along.

- |pyinstaller|_ : bundle a Python application and all its dependencies

  This formula is now included in Homebrew core repository. See:
  `Homebrew/homebrew-core#38092 <https://github.com/Homebrew/homebrew-core/pull/38092>`__

- |nlohmann_json|_ : JSON for Modern C++

  This formula is now included in Homebrew core repository. See:
  `Homebrew/homebrew-core#38257 <https://github.com/Homebrew/homebrew-core/pull/38257>`__

.. |docutils| replace:: ``docutils``
.. _docutils: http://docutils.sourceforge.net
.. |vermin| replace:: ``vermin``
.. _vermin: https://github.com/netromdk/vermin
.. |sloc| replace:: ``sloc``
.. _sloc: https://github.com/flosse/sloc#readme
.. |pkt2flow| replace:: ``pk2flow``
.. _pkt2flow: https://github.com/caesar0301/pkt2flow#pkt2flow
.. |bpython| replace:: ``bpython``
.. _bpython: https://bpython-interpreter.org
.. |ptpython| replace:: ``ptpython``
.. _ptpython: https://github.com/prompt-toolkit/ptpython
.. |poet| replace:: ``poet``
.. _poet: https://github.com/tdsmith/homebrew-pypi-poet
.. |uti| replace:: ``uti``
.. _uti: https://github.com/alexaubry/uti
.. |ssh-askpass| replace:: ``ssh-askpass``
.. _ssh-askpass: https://github.com/theseal/ssh-askpass
.. |noob| replace:: ``homebrew-npm-noob``
.. _noob: https://github.com/zmwangx/homebrew-npm-noob
.. |bro-pkg| replace:: ``bro-pkg``
.. _bro-pkg: https://docs.zeek.org/projects/package-manager
.. |sphinx| replace:: ``Sphinx``
.. _sphinx: https://www.sphinx-doc.org
.. |pyinstaller| replace:: ``PyInstaller``
.. _pyinstaller: http://www.pyinstaller.org
.. |nlohmann_json| replace:: ``nlohmann::json``
.. _nlohmann_json: https://github.com/nlohmann/json

-------
License
-------

This repo is licensed under the BSD 2-Clause "Simplified" License. See the
`LICENSE <https://github.com/JarryShaw/homebrew-tap/blob/master/LICENSE>`__
file for rights and limitations.

---------------
Acknowledgement
---------------

This `README <https://github.com/JarryShaw/homebrew-tap/blob/master/README.rst>`__
file used `README.md <https://github.com/mas-cli/homebrew-tap/blob/master/README.md>`__
of |mas|_ for reference.

.. |mas| replace:: ``mas-cli/homebrew-tap``
.. _mas: https://github.com/mas-cli/homebrew-tap
