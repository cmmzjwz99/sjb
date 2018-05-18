require 'selenium-webdriver'

class SeleniumWorker
  include Sidekiq::Worker

  def perform
    spider()
  end

  def spider
    begin
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--ignore-certificate-errors')
      options.add_argument('--disable-popup-blocking')
      options.add_argument('--disable-translate')
      options.add_argument('--headless')
      driver = Selenium::WebDriver.for :chrome, options: options
      base_url = 'http://vip.win007.com/AsianOdds_n.aspx?id=1482830'
      driver.get(base_url)
      button = driver.find_element(:xpath, '//*[@id="odds"]/tbody/tr[12]/td[2]/span')
      button.click()

      teams = driver.find_element(:xpath, '//*[@id="webmain"]/table[1]/tbody/tr[2]/td')
      p teams.text.split('vs').split(' ')
      home = '葡萄牙'
      away = '西班牙'
      source = 'bet365'
      while(true)
        element_home = driver.find_element(:xpath, '//*[@id="odds"]/tbody/tr[12]/td[6]')
        element_play = driver.find_element(:xpath, '//*[@id="odds"]/tbody/tr[12]/td[7]')
        element_away = driver.find_element(:xpath, '//*[@id="odds"]/tbody/tr[12]/td[8]')
        p 'Bet365即时盘口1：', element_home.text, element_play.text, element_away.text

        save_if_updated(home, away, element_play.text, element_home.text.to_f, element_away.text.to_f, source)

        element_home = driver.find_element(:xpath, '//*[@id="odds"]/tbody/tr[13]/td[6]')
        element_play = driver.find_element(:xpath, '//*[@id="odds"]/tbody/tr[13]/td[7]')
        element_away = driver.find_element(:xpath, '//*[@id="odds"]/tbody/tr[13]/td[8]')
        p 'Bet365即时盘口2：', element_home.text, element_play.text, element_away.text

        save_if_updated(home, away, element_play.text, element_home.text.to_f, element_away.text.to_f, source)

        element_home = driver.find_element(:xpath, '//*[@id="odds"]/tbody/tr[14]/td[6]')
        element_play = driver.find_element(:xpath, '//*[@id="odds"]/tbody/tr[14]/td[7]')
        element_away = driver.find_element(:xpath, '//*[@id="odds"]/tbody/tr[14]/td[8]')
        p 'Bet365即时盘口3：', element_home.text, element_play.text, element_away.text

        save_if_updated(home, away, element_play.text, element_home.text.to_f, element_away.text.to_f, source)

        driver.navigate().refresh
        sleep(60)
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
      driver.close
      spider()
    end
  end

  def save_if_updated(home,away,rule,home_odd, away_odd,source)
    latest = Odd.where(home_team: home, away_team: away, rule: rule, source: source).last
    if latest.nil? or latest.away_odd != away_odd or latest.home_odd != home_odd
      Odd.create(:home_team=>home,
                 :away_team=>away,
                 :home_odd=>home_odd,
                 :away_odd=>away_odd,
                 :rule=>rule,
                 :source=>source)
    end
  end
end