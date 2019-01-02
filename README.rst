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

- |docutils|_: Documentation Utilities

  This formula is included in Homebrew core repository. However,
  no dependencies, such as ``lxml``, ``Pillow`` and ``Pygments``
  are integrated. For more information, see this
  `Pull Request <https://github.com/Homebrew/homebrew-core/pull/35209>`__.

- |vermin|_: Concurrently detect the minimum Python versions needed to run code

  This formula is not included in Homebrew core repository yet. See this
  `Pull Request <https://github.com/Homebrew/homebrew-core/pull/35633>`__.

- |sloc|_: sloc is a simple tool to count SLOC (source lines of code)

  This formula is not included in Homebrew core repository yet. See this
  `Pull Request <https://github.com/Homebrew/homebrew-core/pull/35632>`__.

.. |docutils| replace:: ``docutils``
.. _docutils: http://docutils.sourceforge.net
.. |vermin| replace:: ``vermin``
.. _vermin: https://github.com/netromdk/vermin
.. |sloc| replace:: ``sloc``
.. _sloc: https://github.com/flosse/sloc#readme

-------
License
-------

This repo is licensed under the MIT License. See the
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
