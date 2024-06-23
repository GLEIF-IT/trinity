#!/usr/bin/env python
# -*- encoding: utf-8 -*-
from glob import glob
from os.path import basename
from os.path import splitext

from setuptools import find_packages
from setuptools import setup

setup(
    name='trinity',
    version='0.0.1',  # also change in src/trinity/__init__.py
    license='None',
    description='Witness rotate service for GLEIF',
    author='Kevin Griffin',
    author_email='kevin.griffin@gleif.org',
    url='https://github.com/GLEIF-IT/trinity',
    packages=find_packages('src'),
    package_dir={'': 'src'},
    py_modules=[splitext(basename(path))[0] for path in glob('src/*.py')],
    include_package_data=True,
    zip_safe=False,
    classifiers=[
        'Development Status :: 3 - Alpha',
    ],
    project_urls={
        'Issue Tracker': 'https://github.com/GLEIF-IT/trinity/issues',
    },
    keywords=[
        "keri",
        "witness",
        "rotation",
    ],
    python_requires='>=3.12.2',
    install_requires=[
        'hio>=0.6.12',
        'keri>=1.2.0-dev1',
        'multicommand>=1.0.0',
        'dataclasses_json>=0.5.7',
    ],
    extras_require={
    },
    tests_require=[
        'coverage>=5.5',
        'pytest>=6.2.4',
    ],
    setup_requires=[
    ],
    entry_points={
        'console_scripts': [
            'trinity = trinity.app.cli.trinity:main',
        ]
    },
)