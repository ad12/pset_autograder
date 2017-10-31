import os
import imp

ERROR = "error";

def get_latest_submissions(directory):
    if (directory == ERROR):
        return NULL;

    netids = set();
    latest_submissions = [];
    for sub_num in os.listdir(directory):
        if sub_num != '.DS_Store':
            netid_stripped = sub_num[:-2]
            if netid_stripped in netids:
                latest_submissions[-1] = sub_num
            else:
                netids.add(netid_stripped)
                latest_submissions.append(sub_num);

    return latest_submissions;



if __name__ == "__main__":
    get_latest_submissions(ERROR);
