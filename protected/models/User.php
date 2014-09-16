<?php

/**
 * This is the model class for table "dm_user".
 *
 * The followings are the available columns in table 'dm_user':
 * @property integer $id
 * @property string $name
 * @property string $password
 * @property string $email
 * @property integer $type
 */
class User extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'dm_user';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name, password, email', 'required'),
			array('type', 'numerical', 'integerOnly'=>true),
			array('name, password, email', 'length', 'max'=>45),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('name, password, email, type', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'name' => 'Name',
			'password' => 'Password',
			'email' => 'Email',
			'type' => 'Type',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 *
	 * Typical usecase:
	 * - Initialize the model fields with values from filter form.
	 * - Execute this method to get CActiveDataProvider instance which will filter
	 * models according to data in model fields.
	 * - Pass data provider to CGridView, CListView or any similar widget.
	 *
	 * @return CActiveDataProvider the data provider that can return the models
	 * based on the search/filter conditions.
	 */
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('name',$this->name,true);
		$criteria->compare('password',$this->password,true);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('type',$this->type);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return User the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
         /**
         * Generates the password hash after validation.
         * @param string staff_password
         * @return string hash
         */
        
        protected function afterValidate()
        {
            parent::afterValidate();
            if(!$this->hasErrors()){
                $this->password = $this->hashPassword($this->password);                
            }
        }
        
        /**
         * Generates the password hash.
         * @param string staff_password
         * @return string hash
         */
    
        public function hashPassword($password)
        {
            return md5($password);
        }
        
        /**
	 * Returns the password for the user encrypted.
	 * The hasPassword method is a new method
         * 
	 */
        public function validatePassword($password)
        {
            return $this->hashPassword($password)===$this->password;
        }
        
        /**
         * Assigns users to admin or DGSA staff and apllies to
         * the data base crms_auth_item         * 
         */
        public function afterSave() {
            
         if(!Yii::app()->authManager->isAssigned('admin', $this->id) && !Yii::app()->authManager->isAssigned('viewer', $this->id)) {
                if($this->type === "0"){
                    Yii::app()->authManager->assign('admin', $this->id);
                } elseif($this->type === "1") {
                    Yii::app()->authManager->assign('viewer', $this->id);
                }
            }
            
            return parent::afterSave();
        }
}
