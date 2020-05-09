import os

if __name__ == "__main__":

    prefixes = [
        # "char_spaced_lower",
        # "char_no_space_lower",
        # "subchar_spaced_lower",
        # "subchar_no_space_lower",
        "subchar_segmented_lower",
    ]

    STORAGE_BUCKET = "gs://sbt0"

    for prefix in prefixes:
        input_dir_gs = os.path.join(
            STORAGE_BUCKET,
            "data/corpus/%s/zhwiki-latest-pages-articles_%s.txt" % (prefix, prefix)
        )
        input_dir_local = "./zhwiki-latest-pages-articles_%s.txt" % prefix
        tf.gfile.Copy(input_dir_gs, input_dir_local, overwrite=True)