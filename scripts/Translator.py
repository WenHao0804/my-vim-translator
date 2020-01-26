#============================================================
# Last modify:			2020-01-25 23:30:30
# Create Time:			2020-01-25 22:53:51
# Writer:				Wenhao	1795902848@qq.com
# File Name:			Translator.py
# File Type:			PY Source File
# Information:
#============================================================
#coding=utf-8
import argparse
import requests, json
from lxml import etree

class Translator:
    def IcibaEn2Ch(this, content):
        """爱词霸翻译，英文单词翻译中文"""
        content = '%20'.join(content.split())
        url = "http://www.iciba.com/%s"%content
        headers = {
                'Host': 'www.iciba.com',
                'Referer': 'http://www.iciba.com/years',
                'Upgrade-Insecure-Requests': '1',
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36' }
        r = requests.get(url=url, headers=headers)
        raw_txt = r.content.decode('utf-8')
        html = etree.HTML(raw_txt)

        read = html.xpath('//div[@class="base-speak"]//text()')
        read  = "\n".join([line for line in read if line.strip() != ""])

        means = html.xpath('//li[@class="clearfix"]//text()')
        means = [mean for mean in means if mean.strip() != ""]
        means = [mean if mean[0] not in ['a', 'i', 'n', 'v', 'c', 'p'] else "\n"+mean \
                for mean in means]
        means = " ".join(means)
        trans = read+means
        trans = trans.replace('\n', '_')
        return trans

    def IcibaCh2En(this, chinese_str):
        """爱词霸翻译，中文翻译至英文"""
        url = 'http://fy.iciba.com/ajax.php?a=fy'
        data = {
            'f': 'auto',
            't': 'auto',
            'w': chinese_str
        }
        headers = {
            'Connection': 'keep-alive',
            'Cookie': 'iciba_u_rand=4dcd6756b08bf97810170c02b3658b3b%4027.155.93.75; iciba_u_rand_t=1579071593; UM_distinctid=16fa80087f10-0be051d24fbfdf-39657c0a-fa000-16fa80087f2304; CNZZDATA1256573702=97630578-1579067233-http%253A%252F%252Fwww.iciba.com%252F%7C1579067233',
            'Host': 'fy.iciba.com',
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36'
        }
        r = requests.post(url=url, headers=headers, data=data)
        raw_txt = r.content.decode('utf-8')
        data_json = json.loads(raw_txt)
        trans = data_json.get('content').get('out')
        return trans

    def set_engine(this, engine):
        funs = {
            'iciba':{'en2ch':this.IcibaEn2Ch, 'ch2en':this.IcibaCh2En}
        }
        this.translateInterface = funs[engine]

    def translate(this, content, type):
        tf = this.translateInterface[type]
        translation = tf(content)
        if translation == None:
            translation = ""
        return translation

def _argparse():
    """https://www.cnblogs.com/zydev/p/8645286.html"""
    parser = argparse.ArgumentParser()
    parser.add_argument('--type', default='en2ch')
    parser.add_argument('--content', default='')
    parser.add_argument('--engine', default='iciba')
    return parser.parse_args()

if __name__ == '__main__':
    parser = _argparse()
    translator = Translator()
    translator.set_engine(parser.engine)
    translation = translator.translate(content=parser.content, type=parser.type)
    print(translation)
