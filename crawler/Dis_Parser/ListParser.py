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
        print str(Exception) + '---OpenUrlError---'
    return contents

def dump_url(url):
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

def parseHotelList(url):
    dump_url(url)
    visited_url={}
    html = url_open(url)
    soup = BeautifulSoup(html, "html5lib")
    re_action = re.compile(r"(.*)-(.*)-(.*).*")
    page_no = get_last_page_no(soup)
    m = re_action.search(url)
    hotelUrl = []
    for i in xrange(0,page_no):
        print i,"aa",page_no
        nurl = m.group(1)+'-'+m.group(2)+'-'+'oa'+(str)(i*30)+'-'+m.group(3)
        if nurl in visited_url.keys(): 
            continue
        visited_url[nurl]=1
        html = url_open(nurl)
        soup = BeautifulSoup(html, "html5lib")
        dump_url(nurl)
        print "xxxxx", url
        titlelist = soup.find_all('div',attrs={"class":"listing_title"})
        for title in titlelist:
            if title.find('a'):
                t = title.find('a')['href']
                hotelUrl.append(root+t)
    # input()
    # print hotelUrl
    # print len(hotelUrl)
    writeList(hotelUrl,"Hotels")
    '''
    for hotel in hotelUrl:
        res = []
        res.append(parseHotel(hotel))
        writeToFile(res,'Hotels')
    '''
    return len(hotelUrl)






def parseRestaurantList(url):
    # dump_url(url)
    print "aa"
    visited_url={}
    html = url_open(url)
    soup = BeautifulSoup(html, "html5lib")
    re_action = re.compile(r"(.*)-(.*)-(.*).*")
    page_no = get_last_page_no(soup)
    # print page_no
    m = re_action.search(url)
    restaurantList = []
    cnt = 0
    titlelist = None
    for i in xrange(0,page_no):
        print i,"aa",page_no
        nurl = m.group(1)+'-'+m.group(2)+'-'+'oa'+(str)(i*30)+'-'+m.group(3)
        if nurl in visited_url.keys(): 
            continue
        visited_url[nurl]=1
        html = url_open(nurl)
        soup = BeautifulSoup(html, "html5lib")
        # dump_url(nurl)
        titlelist = soup.find_all('div',attrs={"class":"listing"})
        for r in titlelist:
            if r.find('a',attrs={"class":"property_title"}):
                t = r.find('a')['href']
                restaurantList.append(root+t)
                # print cnt
                cnt += 1
    # print restaurantList
    # print len(restaurantList)
                #######################################################################   test
        # break
    print str(len(titlelist)) + " length &&&"

    # new file
    writeList(restaurantList,"Restaurants")
    for rest in restaurantList:
        res = []
        res.append(parseRestaurant(rest))
        # print res[0]['title'] + "asdfasdf"
        writeToFile(res, 'Restaurant')
    # writeToFile(res,'Restaurant')
    print str(len(titlelist)) + " length asdasdfasdfasdfadfas"
    return len(titlelist)




def get_last_page_no(soup):
    page_no = -1
    #for page in soup.find_all("a",attrs ={"class":"pageNum last taLnk"} ) :
    for page in soup.find_all("a",attrs ={"class":"pageNum taLnk"} ) :
        p = unicode (page.string.strip())
        if p != None and int(p) > page_no:
            page_no = int(p)
    return page_no
def parseAttractionList(url):
    visited_url={}
    html = url_open(url)
    soup = BeautifulSoup(html, "html5lib")
    re_action = re.compile(r"(.*)-(.*)-(.*).*")
    page_no = get_last_page_no(soup)
    print page_no
    m = re_action.search(url)
    attractionList = []
    titlelist = None
    attraction_re = re.compile(r"Attraction_Review(.*)")
    for i in xrange(0,page_no):
        nurl = m.group(1)+'-'+m.group(2)+'-'+'oa'+(str)(i*30)+'-'+m.group(3)
        if nurl in visited_url.keys(): 
            continue
        visited_url[nurl]=1
        html = url_open(nurl)
        soup = BeautifulSoup(html, "html5lib")
        dump_url(nurl)
        titlelist = soup.find_all('div',attrs={"class":"property_title"})
        print len(titlelist)
        for title in titlelist:
            t = title.find("a")['href']
            mm = attraction_re.search(t)
            if mm != None:
                attractionList.append(root+t)
        titlelist = soup.find_all('div',attrs={"class":"child_attraction"})
        for title in titlelist:
            attractionList.append(root+title.find("a")['href'])
        print " &&& attractionList length " + str(len(attractionList))

    i = 0
    listLen = len(attractionList)
    writeList(attractionList,"Attractions")
    #f = openFile("Attractions")
    '''
    for attraction in attractionList:
        i = i + 1
        print "current processing:", i , "/", listLen
        res = []
        res.append(parseAttraction(attraction))
        writeToFile2(res,f)
    #closeFile(f)
    '''
    return len(titlelist)

def writeList(li,catagory):
    i = 0

    filename = catagory+"_List.json"
    print filename + "       is a list"
    f = open(filename, "w")
    for item in li:
       f.write(str(item)+'\n')
    f.close()

if __name__ == "__main__":
    #root_url="https://www.tripadvisor.com/Tourism-g60750-San_Diego_California-Vacations.html"
    #root_url="https://www.tripadvisor.com/Tourism-g32847-Palm_Springs_California-Vacations.html"
    root_url="https://www.tripadvisor.com/Tourism-g60864-New_Orleans_Louisiana-Vacations.html"
    #root_url = "https://www.tripadvisor.com/Tourism-g45963-Las_Vegas_Nevada-Vacations.html"
    #root_url="https://www.tripadvisor.com/Tourism-g54171-Charleston_South_Carolina-Vacations.html"
    #root_url="https://www.tripadvisor.com/Tourism-g35805-Chicago_Illinois-Vacations.html"
    visited_url={}
    visited_url[root_url]=1
    urlqueue=[]
    root_html = url_open(root_url)
    root_soup = BeautifulSoup(root_html)
    soup = dump_url(root_url)
    navLinks = soup.find('div',attrs={"class":"navLinks"})
    # print navLinks
    for cat in navLinks.find_all('li'):
        if cat.find('a'):
            t = cat.find('a')['href']
            action_re = re.compile(r"/(.*)-g(\d*)-([a-zA-Z0-9-_]*).html")
            m = action_re.search(t)
            aspect = m.group(1)

            if aspect != 'ShowForum' and aspect != 'Travel_Guide' and aspect != 'Flights':
                urlqueue.append(root+t)
    print urlqueue



    parseHotelList(urlqueue[0])

    parseAttractionList(urlqueue[2])

    parseRestaurantList(urlqueue[3])

