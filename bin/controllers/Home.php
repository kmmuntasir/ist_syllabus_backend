<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends REST_Controller
{

	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
		$this->load->model('Program', 'program');
		$output = $this->program->get_all();
//		$output = $this->program->get(2);
		$this->restResponse($output, "Success", "Success", HTTP_OK);
	}
}
