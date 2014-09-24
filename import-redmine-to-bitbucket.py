import sys
import csv
import httplib, urllib, base64
 
def main():
    # set the name of your repository, username and password
    username = "test"
    password = "test"
    repo = "test"
    
    filename = sys.argv[1]
    issues = csv.reader(open(filename))
    issues_out = []
    for issue in issues:
        issue_map = {
            "title": issue[5],
            "content": issue[16]
        }
        if issue[1] == "Closed" or issue[1] == "Resolved":
            issue_map["status"] = "resolved"
        elif issue[1] == "Rejected":
            issue_map["status"] = "wontfix"
        elif issue[1] == "Assigned":
            issue_map["status"] = "open"
        elif issue[1] == "New":
            issue_map["status"] = "new"
        
        if issue[3] == "Bug":
            issue_map["kind"] = "bug"
        elif issue[3] == "Feature":
            issue_map["kind"] = "enhancement"
        
        issues_out.append(issue_map)
    for t in issues_out:
        print t
        base64string = base64.encodestring('%s:%s' % (username, password))[:-1]
        conn = httplib.HTTPSConnection("api.bitbucket.org")
        headers = {"Content-type": "application/x-www-form-urlencoded", "Authorization" : "Basic " + base64string}
        url = "/1.0/repositories/%s/%s/issues/" % (username, repo)
        conn.request("POST", url, urllib.urlencode(t), headers)
        response = conn.getresponse()
        print response.status, response.reason
        conn.close()
 
 
if __name__ == '__main__':
    main()
