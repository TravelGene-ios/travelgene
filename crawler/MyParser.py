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
    res["title"] = str(title.text.strip().encode('utf-8'))

def parseHotelList(url):
    dump_url(url)
    visited_url={}
    html = url_open(url)
    soup = BeautifulSoup(html, "html5lib")
    re_action = re.compile(r"(.*)-(.*)-(.*).*")
    page_no = get_last_page_no(soup)
    # print page_no
    m = re_action.search(url)
    hotelUrl = []
    print page_no
    for i in xrange(0,page_no):
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
    for hotel in hotelUrl:
        res = []
        res.append(parseHotel(hotel))
        writeToFile(res,'Hotels')

    return len(hotelUrl)


def parseHotel(url):
    html = url_open(url)
    soup = BeautifulSoup(html,"html5lib")
    #soup = dump_url(url)
    dump_url(url)
    res = {}
    get_title(soup,res)
    get_hotel_address(soup,res)
    # print "start crawling description..."
    # print url
    # get_description(soup,res)
    get_reviews(soup, res)
    get_ratings(soup, res)
    # print url
    get_hotel_img(soup, res)
    get_hotel_class(soup, res)
    res['category'] = 'hotel';
    # get_location(soup)
    # get_img_url(soup)
    # get_open_hour(soup)

    return res



def get_hotel_img(element, res):
    img_url=""
    if element.find("div",attrs={"id":"BC_PHOTOS"}) == None:
        img_div=element.find("div", attrs={"id":"HR_HACKATHON_CONTENT"})
        img_url_obj=img_div.find("img",attrs={"class":"sizedThumb_thumbnail"})
        if img_url_obj:
            img_url = str(img_url_obj["src"])
        else:
            img_url_container=img_div.find("div",attrs={"class":"sizedThumb_container"})
            if img_url_container:
                img_url = str(img_url_container.find("img")["src"])
        print img_url
    else:
        img_div=element.find("div",attrs={"id":"BC_PHOTOS"})
        if img_div.find("span")== None:
            pass
        else:
            img_span=img_div.find("span")
            if img_span.find("img")['src']== None:
                pass
            else:
                img_url=str(img_span.find("img")['src'])
                print img_url
    res['img_url']=str(img_url) #changed

def get_hotel_address(element, res):
    info = element.find("div",attrs={"class":"header_contact_info"})
    if info==None:
        res['address']=None
        return
    address = ""
    for part in info.find_all("span",attrs={"class":"format_address"}):
        address += part.text
    res['address'] = str(address.strip())

def get_hotel_class(element, res):
    try:
        class_img_div = element.find("img",attrs={"class":"sprite-rating_cl_gry_fill rating_cl_gry_fill cl_gry30"})
        if class_img_div:
            score_alt = class_img_div['alt']
            hotel_class = score_alt.split(" ")[0]
            if hotel_class:
                res['class'] = str(hotel_class)
    except (AttributeError):
        res['class'] = "Unknown"
#using scrapy could crawl the description data
def get_description(element, res):
    descp = element.find("div",attrs={"id":"BODYCON"}).find("div",attrs={"class":"answers_in_head"})
    print descp
    print "@@@@@@@@@@@@@1"
    # ret=descp.
    # print ret

    # print descp.find("div",atrrs={"class":"hr_tabs content_block hr_tabs_block"})

    # res['description']=descp.find("div",attrs={"class":"tabs_descriptive_text"}).text


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




def parseRestaurantList(url):
    # dump_url(url)
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
    for rest in restaurantList:
        res = []
        res.append(parseRestaurant(rest))
        # print res[0]['title'] + "asdfasdf"
        writeToFile(res, 'Restaurant')
    # writeToFile(res,'Restaurant')
    print str(len(titlelist)) + " length asdasdfasdfasdfadfas"
    return len(titlelist)



def parseRestaurant(url):
    html = url_open(url)
    time.sleep(1)
    soup = BeautifulSoup(html, "html5lib")
    dump_url(url)
    print url
    res = {}
    get_title(soup,res)
    get_restaurant_address(soup,res)
    get_ratings(soup,res)
    get_reviews(soup,res)
    get_restaurant_openhour(soup, res)
    get_restaurant_price_range(soup, res)
    res['category'] = 'restaurant'
    # print "title " + res['title']
    # get_restuarant_img(soup, res)
    return res

def get_restaurant_openhour(element, res):
    open_div=""
    if element.find("div",attrs={"class":"time"})==None:
        pass
    else:
        open_div=element.find("div",attrs={"class":"time"}).text
    print open_div
    res["open_hour"]=open_div

def get_restaurant_address(element,res):
    address = ""
    address = element.find("address").find("span").text
    res['address'] = str(address.strip())

def get_restuarant_img(element, res):
    img_url=""
    img_div=element.find("div",attrs={"class":"flexible_photos"})
    # print img_div
    img_url=img_div.find("img",attrs={"id":"HERO_PHOTO"})['src']
    print img_url
    res['img_url']=str(img_url)

def get_restaurant_price_range(element, res):
    try:
        price_range_div=element.find("div",attrs={"class":"detail first price_rating separator"})
        if price_range_div:
            dollar = price_range_div.text
            range = dollar.count('$')
            res['price_range'] = range
        else:
            res['price_range'] = 0
    except (AttributeError):
        res['price_range']="Unknown"


def get_last_page_no(soup):
    page_no = -1
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


    for attraction in attractionList:
        res = []
        res.append(parseAttraction(attraction))
        writeToFile(res,"Attractions")

    return len(titlelist)

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
    # print "title  " + res['title']
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

def writeToFile(res,catagory):
    filename = catagory+"_out.json"
    print filename + "       &&&&&&&&&&&&&&&&&"
    f = open(filename, "a")

    json.dump(res, f)
    f.write("\n")
    print "a"
    # for item in res:
    #    f.write(str(item)+'\n')
    f.close()

root="http://www.tripadvisor.com"
if __name__ == "__main__":
    # parseHotel("http://www.tripadvisor.com/Hotel_Review-g53449-d1563869-Reviews-Fairmont_Pittsburgh-Pittsburgh_Pennsylvania")

    
    root_url="http://www.tripadvisor.com/Tourism-g60763-New_York_City_New_York-Vacations.html"
    #root_url="http://www.tripadvisor.com/Tourism-g60763-New_York_City_New_York-Vacations.html"
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

        # suffix = activity.find("a")['href']
        # page = root + suffix
        # soup = dump_url(page)
        # parse_page(soup)

    while True:
        if parseHotelList(urlqueue[0])!=0:
            break
        print 'try again'
    #
    # print urlqueue[2]

    # parseAttractionList(urlqueue[2])


    while True:
        if parseRestaurantList(urlqueue[3]):
            break
        print 'try again'

