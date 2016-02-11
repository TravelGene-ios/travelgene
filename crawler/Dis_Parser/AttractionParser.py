from bs4 import BeautifulSoup
import re
import json
import sys
import time
import random
import urllib2
import httplib
import html5lib
def url_open(pageUrl):
    headers = {  'User-Agent':'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6'  , 'Referer':'https://itunes.apple.com'} 
    req = urllib2.Request(  url = pageUrl,   headers = headers  )
    contents=""
    try:
        response = urllib2.urlopen(req)
        contents= response.read()
    except (httplib.BadStatusLine, urllib2.HTTPError, Exception):
        print str(Exception) + ' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'

    return contents

def dump_url(url):
    # print "xxxxx", url
    content = url_open(url)
    fname = "html/" + url.split("/")[-1]
    f = open(fname, "w+")
    f.write(content)
    f.close()
    return BeautifulSoup(content)


def get_title(element, res):
    title = element.find("h1")
    if title:
        res["title"] = str(title.text.strip().encode('utf-8'))
    else:
        res["title"] = "Unknown"
def get_reviews(element, res):
    try:
        reviewlist=[]
        review=element.find("div",attrs={"id":"REVIEWS"})     
        reviews=review.find_all("div",attrs={"class":"reviewSelector"})      
        for r in reviews:
            ret = r.find("p",attrs={"class":"partial_entry"})
            if ret != None:
                d = str(ret.text.encode('utf-8'))
                reviewlist.append(d)
        res['review_list']=reviewlist
            # print reviewlist
    except (AttributeError):
        res['review_list']=[]
def get_ratings(element, res):
    try:    
        rating_div=element.find("div",attrs={"class":"rs rating"})
        cnt=rating_div.find("a")
        rate=rating_div.find("img")
        if 'content' in cnt.attrs:
            res['review_count']=str(cnt["content"])
            # cnt.attrs.get('content', 'Unknown')
        else:
            res['review_count']=0

        if 'content' in rate.attrs:
            res['rating_string']=str(rate["content"])
        else:
            res['rating_string']=0

    except (KeyError, AttributeError):
        res['review_count']="Unknown"
        res['rating_string']="Unknown"

def getAttraction():
    i = 1
    res = []
    for line in open('Attractions_List.json').xreadlines():
        print i,"++++",line
        i = i + 1
        res.append(parseAttraction(line))
        writeToFile2(res,"Attractions")

def parseAttraction(url):
    html = url_open(url)
    soup = BeautifulSoup(html, "html5lib")
    dump_url(url)
    res = {}
    get_title(soup,res)
    get_attraction_address(soup,res)
    get_reviews(soup,res)
    get_ratings(soup,res)
    res['category'] = "spot"
    print url
    return res

def get_attraction_address(element,res):
    try:
        ad = element.find('address')
        ad = ad.text
        action_re = re.compile(r"Address:(.*)")
        m = action_re.search(ad)
        res['address']=str(m.group(1).strip().encode('utf-8'))
    except (AttributeError):
        res['address'] = "Unknown"
def writeList(li,catagory):
    filename = catagory+"_List.json"
    print filename + "       is a list"
    f = open(filename, "w")
    for item in li:
       f.write(str(item)+'\n')
    f.close()

def openFile(catagory):
    filename = catagory+"_out.json"
    print filename + "       &&&&&&&&&&&&&&&&&"
    f = open(filename, "a")
    return f
def writeToFile(res,f):
    json.dump(res, f)
    f.write("\n")
    print "a"
    
def closeFile(f):
    f.close()

def writeToFile2(res,catagory):
    filename = catagory+"_out.json"
    print filename + "       &&&&&&&&&&&&&&&&&"
    f = open(filename, "a")
    json.dump(res, f)
    f.write("\n")
    print "a"
    f.close()


if __name__ == "__main__":
    getAttraction()
