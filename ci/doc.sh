#!/bin/sh
#
mkdir -p _build/html/
pip install -r requirements.txt
pip install -U sphinx loky joblib sphinx_copybutton memory_profiler jax jaxlib anybadge
# fork of sphinx-gallery to run examples in parallel
pip install git+https://github.com/fabianp/sphinx-gallery.git
python setup.py install
cd doc
make html
if [ $? -eq 0 ]; then
    # set up a badge depending on the result of the build
    anybadge --label=doc --value=passing --file=_build/html/doc_status.svg passing=green failing=red
else
    anybadge --label=doc --value=failing --file=_build/html/doc_status.svg passing=green failing=red
fi
