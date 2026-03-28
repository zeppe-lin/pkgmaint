#!/usr/bin/env python3
# finddepspyproject - find Python module dependencies from distribution metadata
# See COPYING for license terms and COPYRIGHT for notices.

import tomllib
import os

def get_dependencies_from_pyproject(file_path="pyproject.toml"):
    """
    Reads a pyproject.toml file and extracts project dependencies.
    """
    if not os.path.exists(file_path):
        print(f"Error: {file_path} not found.")
        return

    try:
        with open(file_path, "rb") as f:
            data = tomllib.load(f)
    except tomllib.TOMLDecodeError as e:
        print(f"Error decoding TOML file: {e}")
        return

    # Try to get dependencies from the standard [project] table (PEP 621)
    standard_deps = data.get("project", {}).get("dependencies", [])

    # If using Poetry, dependencies are in the [tool.poetry] table
    poetry_deps = data.get("tool", {}).get("poetry", {}).get("dependencies", {})
    # For Poetry, dependencies are a dictionary, so convert to a list
    # of strings
    if poetry_deps:
        # Exclude 'python' version specifier, as it's not a package
        # dependency
        poetry_deps_list = [f"{k}{v}" if not str(v).startswith(('^', '>', '<', '=', '~')) else f"{k}{v}" for k, v in poetry_deps.items() if k.lower() != 'python']
    else:
        poetry_deps_list = []

    # Combine both (a project usually uses one style or the other)
    all_dependencies = standard_deps if standard_deps else poetry_deps_list

    return all_dependencies

# Example usage:
dependencies = get_dependencies_from_pyproject()

if dependencies:
    print("Project Dependencies:")
    for dep in dependencies:
        print(f"* {dep}")
else:
    print("No dependencies found or file not parsed correctly.")

# Optionally, get optional dependencies, e.g., 'test' dependencies:
def get_optional_dependencies(file_path="pyproject.toml", group_name="test"):
    with open(file_path, "rb") as f:
        data = tomllib.load(f)

    # Standard optional dependencies (PEP 621)
    optional_deps = data.get("project", {}).get("optional-dependencies", {}).get(group_name, [])

    # Poetry dev dependencies (often treated like an optional group)
    if not optional_deps:
         optional_deps = data.get("tool", {}).get("poetry", {}).get("dev-dependencies", {}) # Note: 'dev-dependencies' table name is tool-specific

    return optional_deps

# Example usage for test dependencies:
# test_deps = get_optional_dependencies(group_name="test")
# print(f"\nTest Dependencies: {test_deps}")

# End of file.
