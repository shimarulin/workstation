import os


def get_project_root(path=os.path.abspath(__file__)):
    if os.path.exists(os.path.join(path, "pyproject.toml")):
        return path
    else:
        if os.path.dirname(path) == path:
            return ""
        else:
            return get_project_root(os.path.dirname(path))
