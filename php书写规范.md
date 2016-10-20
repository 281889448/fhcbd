PHP书写规范

一. 通用
    1. 缩进2个空格(推荐2个, 也可4个)
    2. 语义化, 看到名字，就知道什么意思
    3. 通用前缀
        +   is表示是否
        +   get表示读取
        +   set表示写
        is后面优先跟形容词，二不是名词
    4. 单数和复数
        +   getUser
        +   getUsers
        +   getFriendsName
    5. 冗余后缀
        尽量不使用data、list、info后缀，除非特殊情况。如：
        +   getElementsByTagName 而不是 getElementsInfoByTagName
        +   getUser 而不是 getUserInfo 或 getUserData
    6. 使用URI, 而不是URL

二. 类名与类文件
    1. 类名：首字大写+驼峰
    2. 类文件:Users.class.php 或 UsersController.class.php(ThinkPHP规范)
    3. 非类文件： 全部小写，下划线分隔 get_user.php
    4. 目录名：全部小写，下划线分隔

三. 函数名
    1. 小写字母开头，驼峰命名，如 function addBlog()
    2. 优先使用动词，如 editBlog 而不是 blogEdit,不赞成 json_encode 这样的写法
    3. 两个函数间要空一行，函数按英文字母排序
    4. 注释，如:
    
        类注释
        /**
         * XXXX 的 YYYY
         * @author Zix
         * @created 2015-11-11
         */
        
        函数注释
        /**
         * 根据条件查询用户
         * @param array $config array( //查询条件
         *   "id" => "" //id
         *   //...
         * )
         * @return array
         */
        function getUsers( $config ) {
          //查询默认值
          $default = array(
            'limit' => 0 ,
            'page' => 1 ,
            'page_size' => 10 ,
          );

          //合并查询条件
          extent( &$config , $default );
          try {
            $result = $this->db->where( $where )->select();
            if ( $result === false ) {
              throw new Exception('sql执行失败' . $this->db->_sql() );
            }
            return ajax_return( '200' , $result );
          } catch( $e ) {
            return ajax_return( '400' , $e->getMessage() );
          }
          
        }


四. URI
    根据rfc1034国际标准的规定，域名中禁止出现下划线“_”，域名不区分大小写。
    1. URI中使用全小写, GET的name为小写(非驼峰) 但是GET值除外
    2. URI中优先使用减号"-", 而不是下划线"_" 
    如：
    -   http://example.com/?user_id=123
    -   http://example.com/1-2-2

五. 变量
    1. 全部小写，下划线分隔，如：$user_id
    2. 不要使用 $_PUT $_DELETE

六. 常量
    全大写， 下划线分隔
    const PAY_SUCCESS = 20 ;
    const FLAG = 'ok'

七. 大括号
    function getUser() {
      //...
    }

    if( !empty( $name ) ) {
      //...
    }

    switch (...) {
      case 1:
        //...
        break;
      case 2:
        //...
        break;
      default:
    }

    $user = array(
      'id" => '123',
      'name' => 'user1',
      'email' => 'a@example.com',
    );

    $users_id = array('23','12','24');//确定

    正确：
    if( !empty($name) ) {
        doSomething();
    }
    错误：
    if(!empty($name))
        doSomething();

八、单引号和双引号
  优先使用单引号!
  echo 'name is:' . $name . '.' . "\n"; //注意 "\n"
  echo "name is: $name . \n";
  echo "name is: {$data['name']} . \n"

九. 表达式
  $name = 'Jack'; //等号两边留1个空格
  !empty( $name ) ? $name : "noname" ; // ? ， : 和 ； 两边留1个空格
  return $name || 'noname' ;
  function（$queryStr , $username）{ //注意() 和 ,

  }

十. 每行长度
  每行代码长度最好不要超过 80 个字符 ，可以打开 IDE 标尺(或辅助线)

  



