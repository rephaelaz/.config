function random_w3_message
    set -l messages \
        # Humans
        "Ready to work." \
        "Ready for action." \
        "Locked and loaded!" \
        "I await your command." \
        # Orcs
        "Work, work." \
        "Zug zug." \
        "Ready to ride." \
        # Undeads
        "What is your will?" \
        "I wish only to serve." \
        "I gladly obey." \
        "Why have I been summoned?" \
        # Night Elfs
        "I stand ready."
    echo (random choice $messages)
end