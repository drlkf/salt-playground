#!/usr/bin/env python3


def ext_pillar(minion_id, *_args, **_kwargs):
    return {"toto": "titi"}


if __name__ == "__main__":
    assert True
