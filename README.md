# Standalone Python
![](/assets/icon.png)

**Empower Your Python Code Everywhere 🐍**

This project provides a versatile solution for running Python in legacy or GLIBC incompatible environments, allowing you to execute version-selected Python scripts effortlessly. 
Whether you're dealing with older systems or specialized setups, this portable
standalone Python is designed to work seamlessly across all Linux platforms.

## Key Features:

- Seamlessly compatible with legacy systems.
- Ideal for GLIBC-incompatible setups.
- Handpicked Python versions for your needs.
- Works effortlessly across all Linux platforms.

## Difference Between Others and This Project:
- [python-build-standalone](https://github.com/indygreg/python-build-standalone)
    - The key difference is that project is relay on system's glibc, and this project is not.
    - There would be a painful issue if you want to run the binary on a system with a different glibc version.
        - like: `./python: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.15' not found (required by ./python)`
    - This project is designed to be compatible with legacy systems, and it is also ideal for GLIBC-incompatible setups.
- [pyinstaller](https://pyinstaller.org/en/stable/)
    - This is a project porting Python to a standalone binary, but it could not be used to run Python scripts directly.
    - It's impossible to deliver a Python script to the endpoint and manipulate pip to install dependencies or other runtime loading operations.
- [nutika](https://github.com/Nuitka/Nuitka)
    - This is a project that compiles Python scripts into C code and then compiles them into binaries.
    - It's not a standalone Python, and it's not a Python script that can be run directly.

## Usage:
- Download the latest release (or you would build it yourself, see [ci](/.github/workflows/build.yml))
- Untar the file, you will see ./opt/python/
- The ./opt/python/ is a standalone Python, you can copy or move it to anywhere you want.
- Run the Python script with the standalone Python:
    - `./opt/python/bin/python ./your_script.py`

# License
Any codes were downloaded from links, follow the license of the original project.

Others are under [MIT License](/LICENSE).

Get started with Standalone Python today and ensure Python compatibility in any
environment! 🚀
