



if __name__ == "__main__":

    from_dir = "src/vocab.txt"
    to_dir = "src/dict.txt"
    with open(from_dir, "r", encoding="utf-8") as f_in:
        with open(to_dir, "w", encoding="utf-8") as f_out:
            count = 0
            for line in f_in:
                line = line.strip()
                if not line:
                    continue

                line = line + " " + str(count)

                f_out.write(line + "\n")
                count += 1

