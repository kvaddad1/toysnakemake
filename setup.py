from setuptools import setup, find_packages

setup(
    name="funtext",
    version="0.1.0",
    description="A simple Snakemake-based text processing workflow",
    author="vnsk",
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        "pyyaml"
    ],
    entry_points={
        "console_scripts": [
            "funtext=funtext.__main__:main"
        ]
    },
) 