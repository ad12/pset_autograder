import os
import imp

ERROR = "error";

def get_latest_submissions(directory):
    if (directory == ERROR):
        return NULL;

    latest_submissions_dict = {}
    netids = set();
    latest_submissions = [];
    for submission in os.listdir(directory):
        if submission != '.DS_Store':
            split_netid = submission.split("_")
            netid_stripped = split_netid[0]
            submission_num = int(split_netid[1])

            if netid_stripped in netids:
                last_sub_num = latest_submissions_dict.get(netid_stripped)
                if last_sub_num != None and last_sub_num < submission_num:
                    latest_submissions_dict[netid_stripped] = submission_num
                    latest_submissions[-1] = submission
            else:
                latest_submissions_dict[netid_stripped] = submission_num
                netids.add(netid_stripped)
                latest_submissions.append(submission);

    return latest_submissions;



if __name__ == "__main__":
    get_latest_submissions(ERROR);
