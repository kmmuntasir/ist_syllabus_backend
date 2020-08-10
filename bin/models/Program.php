<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Program extends MY_Model
{

	public $_table = 'program';
	public $primary_key = 'program_id';

	public function __construct()
	{
		parent::__construct();
	}

	public function getSingleProgram($id)
	{
		return $this->db->where('program_id', $id)->get('program')->row();
	}

//	public function insert_user($user)
//	{
//		$this->db->trans_start();
//		$this->db->insert('user', $user);
//		$this->db->trans_complete();
//		return ($this->db->trans_status()) ? $this->db->insert_id : null;
//	}


}
