<?php
namespace App\Controller;

use App\Form\UserType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpClient\HttpClient;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class UserController extends AbstractController
{
    private string $api;

    public function __construct()
    {
        $this->api = $_ENV['API_URL'];
    }

    #[Route('/users', name: 'users_index')]
    public function index(Request $request): Response
    {
        $users = HttpClient::create()->request('GET', $this->api.'/users')->toArray();
        return $this->render('users/index.html.twig', ['users' => $users]);
    }

    #[Route('/users/new', name: 'users_new')]
    public function new(Request $request): Response
    {
        $form = $this->createForm(UserType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            HttpClient::create()->request('POST', $this->api.'/users', [
                'json' => $form->getData()
            ]);
            return $this->redirectToRoute('users_index');
        }

        return $this->render('users/form.html.twig', ['form' => $form->createView(), 'title' => 'Create']);
    }

    #[Route('/users/{id}/edit', name: 'users_edit')]
    public function edit(int $id, Request $request): Response
    {
        $client = HttpClient::create();
        $user = $client->request('GET', $this->api.'/users/'.$id)->toArray();

        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $client->request('PUT', $this->api.'/users/'.$id, [
                'json' => $form->getData()
            ]);
            return $this->redirectToRoute('users_index');
        }

        return $this->render('users/form.html.twig', ['form' => $form->createView(), 'title' => 'Edit']);
    }

    #[Route('/users/{id}/delete', name: 'users_delete', methods: ['POST'])]
    public function delete(int $id): Response
    {
        HttpClient::create()->request('DELETE', $this->api.'/users/'.$id);
        return $this->redirectToRoute('users_index');
    }
}
